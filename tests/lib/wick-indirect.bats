#!../bats/bats

setup() {
    load ../wick-test-base
    . "$WICK_DIR/lib/wick-indirect"
}

test-one-level() {
    local RESULT

    test-one-level-set RESULT

    echo "$RESULT"
}

test-one-level-set() {
    local "$1" && wickIndirect "$1" "one"
}

@test "lib/wick-indirect: one level" {
    [ "$(test-one-level)" == "one" ]
}

test-conflicting-variables() {
    local AAA

    AAA="before"
    test-conflicting-variables-set1 AAA
    echo "$AAA"
}

test-conflicting-variables-set1() {
    local AAA

    AAA="set1-before"
    test-conflicting-variables-set2 AAA
    AAA="$AAA + set1"
    local "$1" && wickIndirect "$1" "$AAA"
}

test-conflicting-variables-set2() {
    local AAA

    AAA="set2-before"
    local "$1" && wickIndirect "$1" "set2"
}

@test "lib/wick-indirect: conflicting variables" {
    [ "$(test-conflicting-variables)" == "set2 + set1" ]
}
