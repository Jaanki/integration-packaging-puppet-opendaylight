# Contributing to the OpenDaylight Puppet Module

We work to make contributing easy. Please let us know if you spot something
we can do better.

#### Table of Contents

1. [Overview](#overview)
2. [Communication](#communication)
   - [Issues](#issues)
   - [IRC channel](#irc-channel)
3. [Patches](#patches)
4. [Testing](#testing)
   - [Test Dependencies](#test-dependencies)
   - [Syntax and Style Tests](#syntax-and-style-tests)
   - [Unit Tests](#unit-tests)
   - [System Tests](#system-tests)
   - [Tests in Continuous Integration](#tests-in-continuous-integration)

## Overview

We use [GitHub Issues][1] for most communication, including bug reports,
feature requests and questions.

We accept patches via [GitHub Pull Requests][2]. Please fork our repo,
make your changes, commit them to a feature branch and *submit a PR to
have it merged back into this project*. We'll give feedback and get it
merged ASAP.

## Communication

*Please use public, documented communication instead of reaching out to
developers 1-1.*

Open Source projects benefit from always communicating in the open. Previously
answered questions end up becoming documentation for other people hitting
similar issues. More eyes may get your question answered faster. Doing
everything in the open keeps community members on an equal playing field
(`@<respected company>` email addresses don't get priority, good questions do).

We prefer [Issues][1] for most communication.

### Issues

Please use our [GitHub Issues][1] freely, even for small things! They are the
primary method by which we track what's going on in the project.

The labels assigned to an issue can tell you important things about it.

For example, issues tagged [`good-for-beginners`][3] are likely to not require
much background knowledge and be fairly self-contained, perfect for people new
to the project who are looking to get involved.

The priority-related issue labels ([`prio:high`][4], [`piro:normal`][5]...)
are also important to note. They typically accurately reflect the next TODOs
the community will complete.

The `info:progress` labels may not always be up-to-date, but will be used when
appropriate (typically long-standing issues that take multiple commits).

Issues can be referenced and manipulated from git commit messages. Just
referencing the issue's number (`#42`) will link the commit and issue. Issues
can also be closed from commit messages with `closes #42` (and [a variety
of other key words][6]).

### IRC channel

Feel free to join us at **#opendaylight-integration** on `chat.freenode.net`.
You can also use web client for Freenode to join us at [webchat][19].

## Patches

Please use [Pull Requests][2] to submit patches.

Basics of a pull request:

- Use the GitHub web UI to fork our repo.
- Clone your fork to your local system.
- Make your changes.
- Commit your changes, using a [good commit message][7] and referencing any
  applicable issues.
- Push your commit.
- Submit a pull request against the project, again using GitHub's web UI.
- We'll give feedback and get your changed merged ASAP.
- You contributed! [Thank you][8]!

Other tips for submitting excellent pull requests:

- If you'd like to make more than one logically distinct change, please submit
  them as different pull requests (if they don't depend on each other) or
  different commits in the same PR (if they do).
- If your PR contains a number of commits that provide one logical change,
  please squash them using `git rebase`.
- Please provide test coverage for your changes.
- If applicable, please provide documentation updates to reflect your changes.

## Testing

### Test Dependencies

The testing tools have a number of dependencies. We use [Bundler][9] to make
installing them easy.

```
$ sudo yum install -y rubygems ruby-devel gcc-c++ zlib-devel patch \
    redhat-rpm-config make
$ gem install bundler
$ bundle install
$ bundle update
```

### Syntax and Style Tests

We use [Puppet Lint][10], [Puppet Syntax][11] and [metadata-json-lint][12] to
validate the module's syntax and style.

```
$ bundle exec rake lint
$ bundle exec rake syntax
$ bundle exec rake metadata
```

### Unit Tests

We use rspec-puppet to provide unit test coverage.

To run the unit tests and generate a coverage report, use:

```
$ bundle exec rake spec
# Snip test output
Finished in 10.08 seconds (files took 0.50776 seconds to load)
537 examples, 0 failures


Total resources:   19
Touched resources: 19
Resource coverage: 100.00%
```

Note that we have a very large number of tests and 100% test coverage.

To run the syntax, style and unit tests in one rake task (recommended), use:

```
$ bundle exec rake test
```

### System Tests

While the [unit tests](#unit-tests) are able to quickly find many errors,
they don't do much more than checking that the code compiles to a given state.
To verify that the Puppet module behaves as desired once applied to a real,
running system, we use [Beaker][13].

Beaker stands up virtual machines or containers using Vagrant or Docker,
applies the OpenDaylight Puppet module with various combinations of params
and uses [Serverspec][14] to validate the resulting system state.

Beaker depends on Vagrant ([Vagrant downloads page][17]) for managing VMs,
which in turn depends on VirtualBox ([VirtualBox downloads page][18]) and
the `kmod-VirtualBox` package.

Beaker depends on [Docker][20] for managing containers.

To run Beaker tests against CentOS 7 in a VM using the latest OpenDaylight
Carbon RPM, use:

```
$ bundle exec rake cent_6test_vm
```

To do the same tests in a CentOS container:

```
$ bundle exec rake cent_6test_dock
```

To run VM or container-based tests for all OSs:

```
$ bundle exec rake acceptance_vm
$ bundle exec rake acceptance_dock
```

If you'd like to preserve the Beaker VM after a test run, perhaps for manual
inspection or a quicker follow-up test run, use the `BEAKER_destroy`
environment variable.

```
$ BEAKER_destroy=no bundle exec rake centos
```

You can then connect to the VM by navigating to the directory that contains
its Vagrantfile and using standard Vagrant commands.

```
$ cd .vagrant/beaker_vagrant_files/centos-7.yml
$ vagrant status
Current machine states:

centos-7                  running (virtualbox)
$ vagrant ssh
$ sudo systemctl is-active opendaylight
active
$ logout
$ vagrant destroy -f
```

For more information about using Beaker, see [these docs][15].

### Tests in Continuous Integration

The OpenDaylight Puppet module uses OpenDaylight's Jenkins silo to run tests
in CI. Some tests are triggered when changes are proposed, others are triggered
periodically to validate things haven't broken underneath us. See the
[`puppet-*` tests][21] on the Jenkins web UI for a list of all tests.

[1]: https://github.com/dfarrell07/puppet-opendaylight/issues

[2]: https://github.com/dfarrell07/puppet-opendaylight/pulls

[3]: https://github.com/dfarrell07/puppet-opendaylight/labels/good-for-beginners

[4]: https://github.com/dfarrell07/puppet-opendaylight/labels/prio%3Ahigh

[5]: https://github.com/dfarrell07/puppet-opendaylight/labels/prio%3Anormal

[6]: https://help.github.com/articles/closing-issues-via-commit-messages/

[7]: http://chris.beams.io/posts/git-commit/

[8]: http://cdn3.volusion.com/74gtv.tjme9/v/vspfiles/photos/Delicious%20Dozen-1.jpg

[9]: http://bundler.io/

[10]: http://puppet-lint.com/

[11]: https://github.com/gds-operations/puppet-syntax

[12]: https://github.com/puppet-community/metadata-json-lint

[13]: https://github.com/puppetlabs/beaker

[14]: http://serverspec.org/resource_types.html

[15]: https://github.com/puppetlabs/beaker/wiki/How-to-Write-a-Beaker-Test-for-a-Module#typical-workflow

[17]: https://www.vagrantup.com/downloads.html

[18]: www.virtualbox.org/wiki/Linux_Downloads

[19]: http://webchat.freenode.net/?channels=opendaylight-integration

[20]: https://docs.docker.com/engine/installation/

[21]: https://jenkins.opendaylight.org/releng/view/packaging/search/?q=puppet "Puppet CI jobs"
