class Astroterm < Formula
  desc "Celestial viewer for the terminal, written in C with ncurses"
  homepage "https://github.com/da-luce/astroterm/"
  url "https://github.com/da-luce/astroterm/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "169e7fd4aada124357d814f81f8cd870229b2296252d6cf3834721d100b177ff"
  license "MIT"

  bottle do
    root_url "https://github.com/da-luce/homebrew-astroterm/releases/download/astroterm-1.0.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b10ca5638c1d91177d9586c08909c1752e72eafb6dfe79f3ca03b7c56f30e900"
    sha256 cellar: :any_skip_relocation, ventura:       "15beacca90bd3d92bb85b63a31ccc3ee4e7eefc538e56b65a7b648b6bcd2c6d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec68a8fc9ffbbc979aff768d010ba3137b473851ba294654254052edf8dffd53"
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
