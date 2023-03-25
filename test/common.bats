. "src/common.sh"

@test "can print usage" {
  ( usage "description" "<arg1> <argn>" 2>&1
  )
}

@test "can pass a help flag" {
  ( usage "description" "<arg1> <argn>" --help 2>&1
  )
}

@test "fails to use an arbitrary flag" {
  ! ( usage "description" "<arg1> <argn>" --fubar
    ) 2>&1
}
