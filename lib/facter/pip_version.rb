require 'pathname'

path1 = "/usr/bin/pip"
if File.basename(path1) == "pip"
  Facter.add("pip_version1") do
    setcode do
      Facter::Util::Resolution.exec('/usr/bin/pip --version | cut -d\' \' -f 6 | tr -d "()"')
    end
  end
end

path2 = "/usr/local/bin/pip"
if File.basename(path2) == "pip"
  Facter.add("pip_version2") do
    setcode do
      Facter::Util::Resolution.exec('/usr/local/bin/pip --version | cut -d\' \' -f 6 | tr -d "()"')
    end
  end
end
