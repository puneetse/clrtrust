#!/usr/bin/env bats
# Copyright 2017 Intel Corporation

load test_lib

setup() {
    find_clrtrust
    setup_fs
    cp $CERTS/c[1-2].pem $CLR_CLEAR_TRUST_SRC/trusted
    cp $CERTS/c[3-4].pem $CLR_LOCAL_TRUST_SRC/trusted
    chmod 400 $(dirname ${CLR_TRUST_STORE})
}

@test "check fails when trust store cannot be written" {
    run $CLRTRUST check
    [ $status -ne 0 ]
    [ ! -z "$output" ]
}

teardown() {
    chmod 755 $(dirname ${CLR_TRUST_STORE})
    remove_fs
}

# vim: ft=sh:sw=4:ts=4:et:tw=80:si:noai:nocin
