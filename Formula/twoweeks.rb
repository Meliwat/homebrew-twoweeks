class Twoweeks < Formula
  desc "Time the gap between your AI's confident estimate and your actual ship time"
  homepage "https://github.com/Meliwat/twoweeks"
  url "https://github.com/Meliwat/twoweeks/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "3b5b8036b4931b9fd5d3ed2b2cf27ede33b8516ee6626d3dfc6d3cda1cd708c3"
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
    assert_match "twoweeks v0.6", shell_output("#{bin}/twoweeks --version")
    ENV["TWOWEEKS_HOME"] = testpath/".twoweeks"
    system bin/"twoweeks", "smoke test", "2 weeks"
    assert_match "SHIPPED", shell_output("#{bin}/twoweeks ship --no-color")
  end
end
