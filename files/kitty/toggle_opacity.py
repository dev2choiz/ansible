def main(_) -> None:
    pass


def handle_result(args, answer, target_window_id, boss) -> None:
    import kitty.fast_data_types as f

    current_opacity = f.background_opacity_of(f.current_focused_os_window_id())
    boss.set_background_opacity("default" if current_opacity == 1 else "1")


handle_result.no_ui = True
