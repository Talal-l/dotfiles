p="['#262626', '#E356A7', '#42E66C', '#E4F34A', '#9B6BDF', '#E64747', '#75D7EC', '#EFA554', '#7A7A7A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']"
default_profile_id=$(gsettings get org.gnome.Terminal.ProfilesList default)
default_profile_id="${default_profile_id:1:-1}"
dconfdir=/org/gnome/terminal/legacy/profiles:
profile_path=$dconfdir/:$default_profile_id

bg_color='#282A36'
fg_color='#F8F8F2'
bd_color='#6E46A4'
# set color palette
dconf write $profile_path/palette "$p" 
# set foreground, background and highlight color
dconf write $profile_path/bold-color "'$bd_color'" 
dconf write $profile_path/background-color "'$bg_color'"
dconf write $profile_path/foreground-color "'$fg_color'"

# make sure the profile is set to not use theme colors
dconf write $profile_path/use-theme-colors "false"

# set highlighted color to be different from foreground color
dconf write $profile_path/bold-color-same-as-fg "false"

