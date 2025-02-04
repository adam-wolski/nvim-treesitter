; Gleam indents similar to Rust and JavaScript
[
  (assert)
  (case)
  (case_clause)
  (constant)
  (expression_group)
  (external_function)
  (function)
  (import)
  (let)
  (list)
  (constant)
  (external_function)
  (function)
  (type_definition)
  (type_alias)
  (todo)
  (try)
  (tuple)
] @indent

[
  ")"
  "]"
  "}"
] @indent_end @branch

; Gleam pipelines are not indented, but other binary expression chains are
((binary_expression operator: _ @_operator) @indent (#not-eq? @_operator "|>"))
