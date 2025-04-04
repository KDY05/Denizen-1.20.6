# GUI 부분 /optiongui 인게임 커맨드로 옵션 토글 메뉴 오픈
# 초기 실행시 각 옵션은 비활성화 상태입니다.

main_gui_command:
    type: command
    name: optiongui
    description: 메인메뉴
    usage: /optiongui
    debug: false
    script:
    - if !<player.is_op>:
        - narrate "<&e>운영자 권한이 필요합니다."
        - stop
    - inventory open d:main_gui_inventory_1

main_gui_toggle_task:
    type: task
    definitions: option|player
    debug: false
    script:
    - define enabled <server.flag[text_enabled]>
    - define disabled <server.flag[text_disabled]>
    - if <server.flag[<[option]>]> == <[disabled]>:
        - flag server <[option]>:<[enabled]>
    - else:
        - flag server <[option]>:<[disabled]>
    - playsound <[player]> sound:ENTITY_EXPERIENCE_ORB_PICKUP pitch:1

main_gui_inventory_1:
    type: inventory
    inventory: CHEST
    title: 월드 옵션 토글
    size: 54
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [main_gui_item_damage_share] [] [main_gui_item_inventory_share] [] [main_gui_item_random_damage] [] [main_gui_item_mob_downscale] []
    - [] [main_gui_item_mob_speedup] [] [main_gui_item_weakness] [] [main_gui_item_chain] [] [main_gui_item_one_inventory] []
    - [] [main_gui_item_mob_spawnlimit] [] [main_gui_item_fast_tick] [] [main_gui_item_block_mob] [] [main_gui_item_invisible_mob] []
    - [] [] [] [] [] [] [] [] []
    - [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_first_page] [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_next_page] [main_gui_item_bar] [main_gui_item_bar]

main_gui_inventory_2:
    type: inventory
    inventory: CHEST
    title: 월드 옵션 토글
    size: 54
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [main_gui_item_random_jump] [] [main_gui_item_zombie] [] [main_gui_item_jump_share] [] [main_gui_item_random_pickup] []
    - [] [main_gui_item_hpshow] [] [main_gui_item_random_item] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_prev_page] [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_bar] [main_gui_item_last_page] [main_gui_item_bar] [main_gui_item_bar]

main_gui_world:
    type: world
    debug: false
    events:
        on player clicks in main_gui_inventory_1:
        - define item null
        - choose <context.item.script.name||null>:
            - case main_gui_item_damage_share:
                - define item damage_share

            - case main_gui_item_inventory_share:
                - define item inventory_share

            - case main_gui_item_random_damage:
                - define item random_damage

            - case main_gui_item_mob_downscale:
                - define item mob_downscale
                - if <server.flag[mob_downscale]> == <server.flag[text_disabled]>:
                    - run mob_downscale_toggle_task def.toggle:on
                - else if <server.flag[mob_downscale]> == <server.flag[text_enabled]>:
                    - run mob_downscale_toggle_task def.toggle:off

            - case main_gui_item_mob_speedup:
                - define item mob_speedup
                - if <server.flag[mob_speedup]> == <server.flag[text_disabled]>:
                    - run mob_speedup_toggle_task def.toggle:on
                - else if <server.flag[mob_speedup]> == <server.flag[text_enabled]>:
                    - run mob_speedup_toggle_task def.toggle:off

            - case main_gui_item_weakness:
                - define item weakness

            - case main_gui_item_chain:
                - define item chain

            - case main_gui_item_one_inventory:
                - define item one_inventory
                - if <server.flag[one_inventory]> == <server.flag[text_disabled]>:
                    - run one_inventory_toggle_task def.toggle:on
                - else if <server.flag[one_inventory]> == <server.flag[text_enabled]>:
                    - run one_inventory_toggle_task def.toggle:off

            - case main_gui_item_mob_spawnlimit:
                - define item mob_spawnlimit
                - if <server.flag[mob_spawnlimit]> == <server.flag[text_disabled]>:
                    - run mob_spawnlimit_toggle_task def.toggle:on
                - else if <server.flag[mob_spawnlimit]> == <server.flag[text_enabled]>:
                    - run mob_spawnlimit_toggle_task def.toggle:off

            - case main_gui_item_fast_tick:
                - define item fast_tick
                - if <server.flag[fast_tick]> == <server.flag[text_disabled]>:
                    - run fast_tick_toggle_task def.toggle:on
                - else if <server.flag[fast_tick]> == <server.flag[text_enabled]>:
                    - run fast_tick_toggle_task def.toggle:off

            - case main_gui_item_block_mob:
                - define item block_mob

            - case main_gui_item_invisible_mob:
                - define item invisible_mob
                - if <server.flag[invisible_mob]> == <server.flag[text_enabled]>:
                    - run invisible_mob_off_task

            - case main_gui_item_next_page:
                - inventory open d:main_gui_inventory_2

        - if <[item]> != null:
            - run main_gui_toggle_task def.option:<[item]> def.player:<player>
            - inventory open d:main_gui_inventory_1

        on player clicks in main_gui_inventory_2:
        - define item null
        - choose <context.item.script.name||null>:
            - case main_gui_item_random_jump:
                - define item random_jump
                - if <server.flag[random_jump]> == <server.flag[text_enabled]>:
                    - run random_jump_off_task

            - case main_gui_item_zombie:
                - define item zombie
                - if <server.flag[zombie]> == <server.flag[text_disabled]>:
                    - run zombie_toggle_task def.toggle:on
                - else if <server.flag[zombie]> == <server.flag[text_enabled]>:
                    - run zombie_toggle_task def.toggle:off

            - case main_gui_item_random_pickup:
                - define item random_pickup

            - case main_gui_item_jump_share:
                - define item jump_share

            - case main_gui_item_hpshow:
                - define item tablist_hp_show
                - foreach <server.online_players> as:player:
                    - run util_tablist_update def.player:<[player]> def.health:<[player].health.round_up> delay:1t

            - case main_gui_item_random_item:
                - define item random_item
                - if <server.flag[random_item]> == <server.flag[text_disabled]>:
                    - run random_item_toggle_task def.toggle:on
                - else if <server.flag[random_item]> == <server.flag[text_enabled]>:
                    - run random_item_toggle_task def.toggle:off

            - case main_gui_item_prev_page:
                - inventory open d:main_gui_inventory_1

        - if <[item]> != null:
            - run main_gui_toggle_task def.option:<[item]> def.player:<player>
            - inventory open d:main_gui_inventory_2

main_gui_item_prev_page:
    type: item
    material: paper
    display name: 이전 장

main_gui_item_next_page:
    type: item
    material: paper
    display name: 다음 장

main_gui_item_first_page:
    type: item
    material: barrier
    display name: 첫 장

main_gui_item_last_page:
    type: item
    material: barrier
    display name: 마지막 장

main_gui_item_bar:
    type: item
    material: gray_stained_glass_pane
    display name: ' '