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
`%rustup_toolchain -f rust-toolchain.toml`; the macro reads its `channel` and
`components` values. The existing `%rustup_nightly` macro remains available for packages that
intentionally follow the moving channel, but it is not reproducible and should
be avoided for new packages. Toolchain downloads still require network access
(or a separately provisioned Rustup cache) during the build.

Contributions are welcome, you may submit PRs and our team will review them.
