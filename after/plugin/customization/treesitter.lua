local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },

  ensure_installed = {
    "typescript",
    "javascript",
    "tsx",
    "html",
    "css",
    "json",
    "markdown",
    "markdown_inline",
    "lua",
    "vim",
    "yaml",
    "toml",
    "bash",
  },

  auto_install = true,
})

local function make_subranges_between_children_like(node, predicate)
  local content = {
    { node:range() },
  }

  for child in node:iter_children() do
    if predicate(child) then
      local child_range = { child:range() }
      local last_content_range = content[#content]
      local first_part = {
        last_content_range[1],
        last_content_range[2],
        child_range[1],
        child_range[2],
      }
      local second_part = {
        child_range[3],
        child_range[4],
        last_content_range[3],
        last_content_range[4],
      }
      if IsRangeEmptyOrInvalid(first_part) then
        if not IsRangeEmptyOrInvalid(second_part) then
          content[#content] = second_part
        end
      elseif IsRangeEmptyOrInvalid(second_part) then
        content[#content] = first_part
      else
        content[#content] = first_part
        content[#content + 1] = second_part
      end
    end
  end

  return content
end

local directives = vim.treesitter.query.list_directives()
if not Contains(directives, "inject_without_named_children!") then
  vim.treesitter.query.add_directive("inject_without_named_children!", function(
    match,
    _, --[[ pattern ]]
    _, --[[ bufnr ]]
    predicate,
    metadata
  )
    local node = match[predicate[2]]
    metadata.content = make_subranges_between_children_like(node, function(child)
      return child:named()
    end)
  end)
end

if not Contains(directives, "inject_without_children!") then
  vim.treesitter.query.add_directive("inject_without_children!", function(
    match,
    _, --[[ pattern ]]
    _, --[[ bufnr ]]
    predicate,
    metadata
  )
    local node = match[predicate[2]]
    metadata.content = make_subranges_between_children_like(node, function(_)
      return true
    end)
  end)
end

local ecma_injections = [[
(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; =============================================================================
; styled-components

; styled.div`<css>`
(call_expression
function: (member_expression
  object: (identifier) @_name
    (#eq? @_name "styled"))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled(Component)`<css>`
(call_expression
function: (call_expression
  function: (identifier) @_name
    (#eq? @_name "styled"))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
function: (call_expression
  function: (member_expression
    object: (member_expression
      object: (identifier) @_name
        (#eq? @_name "styled"))))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
function: (call_expression
  function: (member_expression
    object: (call_expression
      function: (identifier) @_name
        (#eq? @_name "styled"))))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; createGlobalStyle`<css>`
(call_expression
function: (identifier) @_name
  (#eq? @_name "createGlobalStyle")
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; css`<css>`
(call_expression
function: (identifier) @_name
  (#eq? @_name "css")
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))
]]

vim.treesitter.query.set("javascript", "injections", ecma_injections)
vim.treesitter.query.set("typescript", "injections", ecma_injections)
vim.treesitter.query.set("tsx", "injections", ecma_injections)
