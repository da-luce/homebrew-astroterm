class Astroterm < Formula
  desc "Celestial viewer for the terminal, written in C with ncurses"
  homepage "https://github.com/da-luce/astroterm/"
  url "https://github.com/da-luce/astroterm/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "169e7fd4aada124357d814f81f8cd870229b2296252d6cf3834721d100b177ff"
  license "MIT"

  bottle do
    root_url "https://github.com/da-luce/homebrew-astroterm/releases/download/astroterm-1.0.3"
    sha256 cellar: :any,                 arm64_sequoia: "af48257203cd5043ec0aa8139f5fe813a16d02fba1822607dcd7dcd4483cd5d0"
    sha256 cellar: :any,                 ventura:       "3b0670722031f77073f7f640b5e2fc1ee57d8960440a0d8a8b1dacb722678ec7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3df6692701923015282d5845bbcadd38e5ab9a2053c91ce94107be56541ce251"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "argtable3"
  depends_on "ncurses"

  # Use dynamic libs when installing via package managers like Homebrew
  def install
    system "curl", "-L", "-o", "data/bsc5", "http://tdc-www.harvard.edu/catalogs/BSC5"
    system "meson", "setup", "build", "-Dprefer_static=false", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
    system "meson", "test", "-C", "build"
  end

  test do
    system bin/"astroterm", "-v"
  end
end
