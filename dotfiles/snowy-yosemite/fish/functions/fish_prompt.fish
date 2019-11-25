# vim: set noet:
#
# Set the default prompt command.

function fish_prompt --description "Write out the prompt"
    set -l color_cwd
    set -l color_user
    set -l color_host

    set -l suffix
    set -l prefix
    switch "$USER"
        case root toor
            set color_user red       
            set suffix '#'
            set suffix ''

            set prefix 'ﮊ'

            set color_cwd purple
            echo -n -s (set_color $color_user) "$prefix $USER " (set_color $color_cwd) (prompt_pwd) "$suffix "



        case '*'
        	set color_user green

            set suffix ''
            # set suffix 'ﲒ'
            # set suffix 'ﬀ'
            # set suffix ''
            # set suffix ''
            # set suffix ''
            # set suffix ''
            # set suffix ''
            # set suffix ''
            # set suffix ''

            # set prefix ''
            set prefix ''

            set color_cwd purple
            echo -n -s (set_color $color_user) "$prefix $USER " (set_color $color_cwd) (prompt_pwd) "$suffix "

    end

    # echo -n -s (set_color $color_user) "$USER" @ (set_color $color_host) (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "


end
