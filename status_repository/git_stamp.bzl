# Copyright (c) 2023, Benjamin Shropshire,
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

"""
# Bazle/skylark rule(s) to instatiate a template with the current git commit.
"""

load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _fit_stamp_impl(ctx):
    if ctx.attr.pattern == "":
        fail("patern must not be null")

    out = ctx.actions.declare_file(ctx.outputs.out.basename)

    ctx.actions.expand_template(
        template=ctx.file.tpl,
        output=out,
        substitutions={
            ctx.attr.pattern: ctx.attr.git_commit[BuildSettingInfo].value,
        },
    )
    return [DefaultInfo(files=depset([out]))]


git_stamp = rule(
    doc = """Insert the current git commit hash into a template.""",
    #
    implementation = _fit_stamp_impl,
    attrs = {
        "out": attr.output(mandatory=True),
        "tpl": attr.label(allow_single_file=True, mandatory=True),
        "pattern": attr.string(default="COMMIT"),
        "git_commit": attr.label(default="@workspace_status//:git-commit"),
    },
)
