# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/cli/cli"
EGO_VENDOR=(
	"github.com/AlecAivazis/survey/v2 v2.0.4 github.com/AlecAivazis/survey"
	"github.com/alecthomas/chroma v0.6.8"
	"github.com/aybabtme/rgbterm cc83f3b3ce59"
	"github.com/cpuguy83/go-md2man v1.0.10"
	"github.com/danwakefield/fnmatch cbb64ac3d964"
	"github.com/dlclark/regexp2 v1.1.6"
	"github.com/google/shlex e7afc7fbc510"
	"github.com/hashicorp/go-version v1.2.0"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/kballard/go-shellquote 95032a82bc51"
	"github.com/kr/text v0.1.0"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.9"
	"github.com/mgutz/ansi 9520e82c474b"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-wordwrap v1.0.0"
	"github.com/russross/blackfriday v1.5.2"
	"github.com/russross/blackfriday/v2 v2.0.1 github.com/russross/blackfriday"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/pflag v1.0.5"
	"github.com/tj/go-css 220a796d1705"
	"github.com/vilmibm/go-termd v0.0.4"
	"golang.org/x/crypto 20be4c3c3ed5 github.com/golang/crypto"
	"golang.org/x/sys fde4db37ae7a github.com/golang/sys"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	"gopkg.in/yaml.v3 fc94e3f71652 github.com/go-yaml/yaml"
)

inherit golang-vcs-snapshot

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

DESCRIPTION="The official GitHub CLI tool."
HOMEPAGE="https://cli.github.com/"
LICENSE="MIT"

SLOT="0"
IUSE=""
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.13"

QA_PRESTRIPPED="/usr/bin/gh"

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x -ldflags "\
		-X github.com/cli/cli/command.Version=${PV} \
		-X github.com/cli/cli/command.BuildDate=$(date +%Y-%m-%d) \
		-s -w" \
		${EGO_PN}/cmd/gh || die
}

src_install() {
	dobin bin/*
}
