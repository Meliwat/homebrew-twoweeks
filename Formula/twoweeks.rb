class Twoweeks < Formula
  desc "Time the gap between your AI's confident estimate and your actual ship time"
  homepage "https://github.com/Meliwat/twoweeks"
  url "https://github.com/Meliwat/twoweeks/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "6fd98ce5b60ea86109c06110e5a7ae7c733328cdf3e6e30ab91ade7af8caddec"
  license "MIT"
  head "https://github.com/Meliwat/twoweeks.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", "--omit=dev", "--ignore-scripts"
    libexec.install "dist", "node_modules", "package.json", "assets"
    (bin/"twoweeks").write <<~SHIM
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    SHIM
    chmod 0755, bin/"twoweeks"
  end

  test do
    assert_match "twoweeks v0.7", shell_output("#{bin}/twoweeks --version")
    ENV["TWOWEEKS_HOME"] = testpath/".twoweeks"
    system bin/"twoweeks", "smoke test", "2 weeks"
    assert_match "SHIPPED", shell_output("#{bin}/twoweeks ship --no-color")
  end
end
