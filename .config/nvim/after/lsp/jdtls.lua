-- jdtls is the one server that is not self-contained. It needs a JDK 21+ to run on
-- and lombok as a -javaagent, and neither comes with the brew formula.
--
-- Both paths are resolved rather than pinned: this repo is shared between a work
-- machine (sdkman, because its services still build on Java 8, so `current` is not
-- a JDK 21) and a personal one (Homebrew openjdk@21, no sdkman).

--- First existing directory from a candidate list.
---@param candidates string[]
---@return string?
local function first_dir(candidates)
  for _, path in ipairs(candidates) do
    local expanded = vim.fn.expand(path)
    if vim.fn.isdirectory(expanded) == 1 then
      return expanded
    end
  end
end

-- Newest sdkman JDK >= 21 first, then Homebrew's keg.
local sdkman = vim.fn.glob('~/.sdkman/candidates/java/*', true, true)
table.sort(sdkman, function(a, b)
  return a > b
end)
local jdks = {}
for _, dir in ipairs(sdkman) do
  local major = tonumber(vim.fn.fnamemodify(dir, ':t'):match('^(%d+)'))
  if major and major >= 21 then
    table.insert(jdks, dir)
  end
end
vim.list_extend(jdks, {
  '/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home',
  '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
})

local java_home = first_dir(jdks)

-- Lombok must be a -javaagent or every generated getter, setter and builder resolves
-- as undefined. This has to go through nvim's own environment, not cmd_env:
-- nvim-lspconfig's get_jdtls_jvm_args() calls os.getenv('JDTLS_JVM_ARGS') while
-- building argv, in this process, before the server is spawned. A cmd_env entry lands
-- too late to be seen and the agent is silently dropped.
local lombok = vim.fn.expand('~/.local/share/java/lombok.jar')
if vim.fn.filereadable(lombok) == 1 then
  vim.env.JDTLS_JVM_ARGS = '-javaagent:' .. lombok
end

-- JAVA_HOME is the opposite case: brew's shim and jdtls.py both read it from the
-- spawned process, so cmd_env is right and keeps it off every other job nvim runs.
return {
  cmd_env = java_home and { JAVA_HOME = java_home } or nil,
}
