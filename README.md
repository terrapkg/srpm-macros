# SRPM Macros for Terra

This repository contains RPM macro definitions for `anda-srpm-macros`.

Documentation for these macros are available in the [Terra documentation](https://docs.terrapkg.com/contributing/srpm).
If you have any problems/questions, please raise an issue in this repository.

## Rust nightly toolchains

Rust nightly packages should pin a dated toolchain instead of using the moving
`nightly` channel. The `%rustup_toolchain` macro creates an isolated Rustup
installation under the RPM build directory and configures the Cargo macros to
use it:

```spec
%bcond rust_nightly 1
BuildRequires: rustup

%prep
%autosetup
%rustup_toolchain -t nightly-2026-08-12 -c rust-src
%cargo_prep_online
```

The `-c` option is optional and can be used for one component such as `rust-src`.
If upstream ships a `rust-toolchain` or `rust-toolchain.toml` file, use
`%rustup_toolchain_from_file`; the macro discovers the file and reads its
`channel` and `components` values. `%rustup_verify_toolchain -t ...` can be
used after setup to fail early if the active compiler does not match the pinned
toolchain. The existing `%rustup_nightly` macro remains available for packages
that intentionally follow the moving channel, but it is not reproducible and
should be avoided for new packages. Toolchain downloads still require network
access (or a separately provisioned Rustup cache) during the build.

For projects that ship a generated `vendor/` directory, offline builds can use:

```spec
%prep
%autosetup
%rustup_toolchain -f rust-toolchain.toml -c rust-src
%cargo_prep_vendor

%build
%cargo_build_offline
```

`%cargo_prep_vendor` requires both `Cargo.lock` and `vendor/`, configures Cargo
against the local vendor tree, and fails early when either is missing.
`%cargo_verify_vendor` can then validate the locked metadata without compiling.
`%cargo_build_offline` adds `--offline`, `--locked`, and
`CARGO_NET_OFFLINE=true` so nested Cargo invocations cannot silently access the
network. The unstable `-Z avoid-dev-deps` option is only added when
`%{with rust_nightly}` is enabled.

Contributions are welcome, you may submit PRs and our team will review them.
