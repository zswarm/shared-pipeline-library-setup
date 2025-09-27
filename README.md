# Purpose

This script is intended to be used by GitHub Runners.
It will automatically parse files from a target directory,
mask them, and output them to `$GITHUB_OUTPUT`.

Usage:


```bash
./shared-pipeline-library-setup.sh "/path/to/my/secrets"
```

## Example

Say your runner has secrets at:

```
/dev/shm/dev/shm/SOME_SECRET
/dev/shm/dev/shm/SOME_OTHER_SECRET
```

Example usage in a workflow:

```bash
- name: Checkout shared pipeline library setup
  uses: actions/checkout@v4
  with:
    repository: zswarm/shared-pipeline-library-setup
    ref: v1
    path: shared-pipeline-library-setup

- name: Setup access for shared pipeline library
  id: shared_pipeline_library_setup
  run: |
    bash shared-pipeline-library-setup/shared-pipeline-library-setup.sh "/dev/shm"
```

You can use it downstream:

```bash
steps.shared_pipeline_library_setup.outputs.some_secret
steps.shared_pipeline_library_setup.outputs.some_other_secret
```
