class Astroterm < Formula
  desc "Terminal-based celestial viewer written in C using ncurses"
  homepage "https://github.com/da-luce/astroterm/"
  url "https://github.com/da-luce/astroterm/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "e2a9500ebb53189397701e8e9e051807b564642b2d1670e75366222678ca361c"
  license "MIT"

  depends_on "argtable" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "argtable"
  depends_on "ncurses"
  uses_from_macos "ncurses" => :build

  def install
    system "curl", "-L", "-o", "data/bsc5", "http://tdc-www.harvard.edu/catalogs/BSC5"
    system "meson", "setup", "build", "-Drelease_build=true", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"astroterm", "-v"
  end
end
