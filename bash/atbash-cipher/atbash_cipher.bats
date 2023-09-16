#!/usr/bin/env bats
load bats-extra

# local version: 1.2.0.0

# encode

@test "encode yes" {
  run bash atbash_cipher.sh encode "yes"
  assert_success
  assert_output "bvh"
}

@test "encode no" {
  run bash atbash_cipher.sh encode "no"
  assert_success
  assert_output "ml"
}

@test "encode OMG" {
  run bash atbash_cipher.sh encode "OMG"
  assert_success
  assert_output "lnt"
}

@test "encode spaces" {
  run bash atbash_cipher.sh encode "O M G"
  assert_success
  assert_output "lnt"
}

@test "encode mindblowingly" {
  run bash atbash_cipher.sh encode "mindblowingly"
  assert_success
  assert_output "nrmwy oldrm tob"
}

@test "encode numbers" {
  run bash atbash_cipher.sh encode "Testing,1 2 3, testing."
  assert_success
  assert_output "gvhgr mt123 gvhgr mt"
}

@test "encode deep thought" {
  run bash atbash_cipher.sh encode "Truth is fiction."
  assert_success
  assert_output "gifgs rhurx grlm"
}

@test "encode all the letters" {
  run bash atbash_cipher.sh encode "The quick brown fox jumps over the lazy dog."
  assert_success
  assert_output "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
}

# decode

@test "decode exercism" {
  run bash atbash_cipher.sh decode "vcvix rhn"
  assert_success
  assert_output "exercism"
}

@test "decode a sentence" {
  run bash atbash_cipher.sh decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
  assert_success
  assert_output "anobstacleisoftenasteppingstone"
}

@test "decode numbers" {
  run bash atbash_cipher.sh decode "gvhgr mt123 gvhgr mt"
  assert_success
  assert_output "testing123testing"
}

@test "decode all the letters" {
  run bash atbash_cipher.sh decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
  assert_success
  assert_output "thequickbrownfoxjumpsoverthelazydog"
}

@test "decode with too many spaces" {
  run bash atbash_cipher.sh decode "vc vix    r hn"
  assert_success
  assert_output "exercism"
}

@test "decode with no spaces" {
  run bash atbash_cipher.sh decode "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
  assert_success
  assert_output "anobstacleisoftenasteppingstone"
}

