[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @none
(variable) @variable

[
 (bracket_comment)
 (line_comment)
] @comment

(normal_command (identifier) @function)

["ENV" "CACHE"] @symbol
["$" "{" "}" "<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket

[
 (function)
 (endfunction)
 (macro)
 (endmacro)
] @keyword.function

[
 (if)
 (elseif)
 (else)
 (endif)
] @conditional

[
 (foreach)
 (endforeach)
 (while)
 (endwhile)
] @repeat

(function_command
  (function)
  . (argument) @function
  (argument)* @parameter
)

(macro_command
  (macro)
  . (argument) @function.macro
  (argument)* @parameter
)

(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (#match? @function.builtin "\\c^(set)$")
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  (
    (argument) @constant
    (#any-of? @constant "PARENT_SCOPE")
  ) .
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  . (argument)
  (
    (argument) @m_cache @constant
    .
    (argument) @m_type @constant
    (#any-of? @m_cache "CACHE")
    (#any-of? @m_type "BOOL" "FILEPATH" "PATH" "STRING" "INTERNAL")
  )
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  . (argument)
  (argument) @m_cache
  (#any-of? @m_cache "CACHE")
  (
    (argument) @m_force @constant
    (#any-of? @m_force "FORCE")
  ) .
)

((argument) @boolean
  (#match? @boolean "\\c^(1|on|yes|true|y|0|off|no|false|n|ignore|notfound|.*-notfound)$")
)

(if_command
  (if)
  (argument) @keyword.operator
  (#any-of? @keyword.operator "NOT" "AND" "OR"
                              "COMMAND" "POLICY" "TARGET" "TEST" "DEFINED" "IN_LIST"
                              "EXISTS" "IS_NEWER_THAN" "IS_DIRECTORY" "IS_SYMLINK" "IS_ABSOLUTE"
                              "MATCHES"
                              "LESS" "GREATER" "EQUAL" "LESS_EQUAL" "GREATER_EQUAL"
                              "STRLESS" "STRGREATER" "STREQUAL" "STRLESS_EQUAL" "STRGREATER_EQUAL"
                              "VERSION_LESS" "VERSION_GREATER" "VERSION_EQUAL" "VERSION_LESS_EQUAL" "VERSION_GREATER_EQUAL"
  )
)

(normal_command
  (identifier) @function.builtin
  . (argument)
  (argument) @constant
  (#any-of? @constant "ALL" "COMMAND" "DEPENDS" "BYPRODUCTS" "WORKING_DIRECTORY" "COMMENT"
                   "JOB_POOL" "VERBATIM" "USES_TERMINAL" "COMMAND_EXPAND_LISTS" "SOURCES")
  (#match? @function.builtin "\\c^(add_custom_target)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "OUTPUT" "COMMAND" "MAIN_DEPENDENCY" "DEPENDS" "BYPRODUCTS" "IMPLICIT_DEPENDS" "WORKING_DIRECTORY"
                      "COMMENT" "DEPFILE" "JOB_POOL" "VERBATIM" "APPEND" "USES_TERMINAL" "COMMAND_EXPAND_LISTS")
  (#match? @function.builtin "\\c^(add_custom_command)$")
)

