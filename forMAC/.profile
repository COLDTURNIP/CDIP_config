
# MacPorts Installer addition on 2011-01-02_at_13:49:06: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Import ~/.bashrc when we finish login.
if [ -r $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

