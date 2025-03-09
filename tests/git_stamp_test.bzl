# Copyright (c) 2025, Benjamin Shropshire,
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load("@com_github_bcsgh_fail_test//fail_test:fail_test.bzl", "fail_test")
load("//status_repository:git_stamp.bzl", "git_stamp")

def git_stamp_suite(name):
    git_stamp(
        name = "git_stamp_basic",
        tpl = "git_stamp_basic.tpl",
        out = "git_stamp_basic.test",
    )

    build_test(
        name = "git_stamp_build_test",
        targets = ["git_stamp_basic.test"],
    )

    diff_test(
        name = "git_stamp_diff_test",
        file1 = "git_stamp_basic.test",
        file2 = "git_stamp_basic.tpl",
        tags = ["manual"],  # Expected to fail so don't run normaly.
    )

    fail_test(
        name = "test_failing_test",
        msgs = ["Hello COMMIT!"],
        test = ":git_stamp_diff_test",
    )

    # Suit
    native.test_suite(
        name = name,
        tests = [
            ":git_stamp_build_test",
        ],
    )
