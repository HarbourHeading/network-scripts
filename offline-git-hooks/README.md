# Offline git pre-commit hooks

Solution to share git hooks with a team, as `.git/hooks/` is not a version controlled file.

Common pre-commit hooks to add to projects. Does not utilize the [pre-commit](https://github.com/pre-commit/pre-commit) framework as that project is mostly dependent on online connectivity, as it fetches from remote repos.
We couldn't use it as we required an offline development solution. For reference, [pre-commit does support local routes](https://stackoverflow.com/a/67796237), but seemed like a little more work than just writing my own pre-commit script.

If you have an online development environment (as most do) I think you are better off using something like [pre-commit](https://github.com/pre-commit/pre-commit).
However, if you like getting your hands dirty writing your own pre-commit hooks, or just require more specialized tooling, then this may serve as a template.

Currently, one pre-commit hook for [python](git-hooks/python/pre-commit) and [ansible](git-hooks/ansible/pre-commit) exist.

## Getting Started

### Project setup

Project owner setup. Add the [setup.sh](setup.sh) file to your project root. It setups the git hook link and permissions.

Copy over whichever config you need, e.g. [python pre-commit](git-hooks/python/pre-commit) to your projects `.githooks` folder.

### Usage

User setup. Assumes you've followed [project setup](#project-setup), or someone else has set it up.
Setup script just tells git (config) to look for hooks in `.githooks/`

Set minimum permission for [setup script](setup.sh)
```bash
chmod +x setup.sh 
```

Run the setup command (inside your project)
````bash
./setup.sh
````

Done. Expanding the hooks is the same process as if they were stored in .git/hooks.

The script assumes you have installed the tools the pre-commit uses, and does not do it for you (in case someone is intentionally not using one of them).
Just `Ctrl + F` "type" in any `pre-commit` file to see which tools to install.

Adding or changing anything is trivial if you know bash, and is strongly advised so it better fits the team and your environment.

### Pre-hooks

In their original state, the scripts do:

#### Python

Uses:
- [black](https://github.com/psf/black) for formatting
- [pylint](https://github.com/pylint-dev/pylint) for linting
- [pytype](https://github.com/google/pytype) for static type analyzing

#### Ansible

Uses:
- [ansible-lint](https://github.com/ansible/ansible-lint) for linting
- [ansible-playbook-grapher](https://github.com/haidaraM/ansible-playbook-grapher) to visualize playbooks. Outputs to graphs/