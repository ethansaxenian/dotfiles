; extends

(
 (call_expression
  (selector_expression
    field:   (field_identifier) @_field)

  (argument_list
    (interpreted_string_literal) @sql))

  (#any-of? @_field "Exec" "GetContext" "ExecContext" "SelectContext" "In" "RebindNamed" "Rebind" "Query" "QueryRow" "QueryRowxContext" "NamedExec" "MustExec" "Get" "Queryx")
  (#offset! @sql 0 1 0 -1)
)


