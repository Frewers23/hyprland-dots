source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    fastfetch
end

fish_add_path /home/frewers/.spicetify

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/frewers/.lmstudio/bin
# End of LM Studio CLI section

