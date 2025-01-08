class Astroterm < Formula
  desc "Celestial viewer for the terminal, written in C with ncurses"
  homepage "https://github.com/da-luce/astroterm/"
  url "https://github.com/da-luce/astroterm/archive/refs/tags/v1.0.2.tar.gz"
  version "1.0.1"
  sha256 "48441dcce970f97dc8c554dfd671c3f268d9517592446ef4df0cdd934603edaa"
  license "MIT"

  depends_on "argtable" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  uses_from_macos "ncurses" => :build

  def install
    system "curl", "-L", "-o", "data/bsc5", "http://tdc-www.harvard.edu/catalogs/BSC5"
    # On linuxbrew, the static argtable2.a lib is NOT PIE, so we must force to compile our executable as not a pie
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"astroterm", "-v"
  end
end
