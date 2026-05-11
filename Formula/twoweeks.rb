class Twoweeks < Formula
  desc "Time the gap between your AI's confident estimate and your actual ship time"
  homepage "https://github.com/Meliwat/twoweeks"
  url "https://github.com/Meliwat/twoweeks/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "522c5f4b935472bcbf62018deb513844d31e12c1b59f1ac68aa038903d31729d"
  license "MIT"
  head "https://github.com/Meliwat/twoweeks.git", branch: "main"

  depends_on "node"
  depends_on "oven-sh/bun/bun" => :build

  def install
    system "bun", "install", "--frozen-lockfile"
    system "bun", "run", "build"
    libexec.install "dist", "node_modules", "package.json", "assets"
    (bin/"twoweeks").write <<~SHIM
      #!/bin/bash
      exec node "#{libexec}/dist/cli.js" "$@"
    SHIM
    chmod 0755, bin/"twoweeks"
  end

  test do
    assert_match "twoweeks v0.5", shell_output("#{bin}/twoweeks --version")
    system bin/"twoweeks", "smoke test", "2 weeks"
    assert_match "SHIPPED", shell_output("#{bin}/twoweeks ship --no-color")
  end
end
