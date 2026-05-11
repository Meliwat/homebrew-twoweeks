class Twoweeks < Formula
  desc "Why your AI assistant always says two weeks but you ship by lunch"
  homepage "https://github.com/Meliwat/twoweeks"
  url "https://github.com/Meliwat/twoweeks/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "7b885a81f66fece780a80887821d255b9ed78bd964a87d0a4745b3adbe65cba7"
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
    assert_match "twoweeks v0.4", shell_output("#{bin}/twoweeks --version")
    system bin/"twoweeks", "smoke test"
    assert_match "SHIPPED", shell_output("#{bin}/twoweeks ship --no-color")
  end
end
