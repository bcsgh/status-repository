<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# A generated repository that exposes (if possible) the current repo's HEAD comit.

## `MODULE.bazel`

```
bazel_dep(
    name = "com_github_bcsgh_status_repository",
    version = ...,
)

status_repository = use_repo_rule("@com_github_bcsgh_status_repository//status_repository:repo.bzl", "status_repository")

status_repository(
    name = "workspace_status",
    alt_git_commit = "<<UNKNOWN>>",
)
```

## Usage

```
load("@workspace_status//:git.bzl", "GIT")

cc_library(
    name = "version",
    hdrs = ["version.h"],
    srcs = ["version.cc"],
    local_defines = ["GIT_COMMIT=%s" % GIT],
)
```

<a id="status_repository"></a>

## status_repository

<pre>
load("@com_github_bcsgh_status_repository//status_repository:repo.bzl", "status_repository")

status_repository(<a href="#status_repository-name">name</a>, <a href="#status_repository-alt_git_commit">alt_git_commit</a>, <a href="#status_repository-repo_mapping">repo_mapping</a>)
</pre>

Create a repository that contains bits of information collected
from the workspace that's not otherwise avalable to build rules.

NOTE: this tends to be somewhat brittle as bazel is aggresive about
caching much of this. To force a refesh, run `bazel sync --configure`.

This infromation is exposed via "setting" rules.

- `//:git-commit`: The current git commit.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="status_repository-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="status_repository-alt_git_commit"></a>alt_git_commit |  The value to use for :git-commit if the real value isn't avalable.   | String | optional |  `""`  |
| <a id="status_repository-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |


## Setup (for development)
To configure the git hooks, run `./.git_hooks/setup.sh`
