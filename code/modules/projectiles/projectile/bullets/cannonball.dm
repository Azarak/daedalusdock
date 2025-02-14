/obj/projectile/bullet/cannonball
	name = "cannonball"
	icon_state = "cannonball"
	damage = 110 //gets set to 100 before first mob impact.
	sharpness = NONE
	projectile_piercing = ALL
	dismemberment = 0
	paralyze = 5 SECONDS
	stutter = 20 SECONDS
	embedding = null
	hitsound = 'sound/effects/meteorimpact.ogg'
	hitsound_wall = 'sound/weapons/sonic_jackhammer.ogg'

/obj/projectile/bullet/cannonball/on_hit(atom/target, blocked = FALSE)
	damage -= 10
	if(damage < 40)
		projectile_piercing = NONE //so it finishes its rampage
	if(blocked == 100)
		return ..()
	if(isobj(target))
		var/obj/hit_object = target
		hit_object.take_damage(80, BRUTE, BULLET, FALSE)
	else if(isclosedturf(target))
		damage -= max(damage - 30, 10) //lose extra momentum from busting through a wall
		if(!isindestructiblewall(target))
			var/turf/closed/hit_turf = target
			hit_turf.ScrapeAway()
	return ..()

/obj/projectile/bullet/cannonball/explosive
	name = "explosive shell"
	color = "#FF0000"
	projectile_piercing = NONE
	damage = 40 //set to 30 before first mob impact, but they're gonna be gibbed by the explosion

/obj/projectile/bullet/cannonball/explosive/on_hit(atom/target, blocked = FALSE)
	explosion(target, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, explosion_cause = src)
	. = ..()

/obj/projectile/bullet/cannonball/emp
	name = "malfunction shot"
	icon_state = "emp_cannonball"
	projectile_piercing = NONE
	damage = 15 //very low

/obj/projectile/bullet/cannonball/emp/on_hit(atom/target, blocked = FALSE)
	empulse(src, 4, 10)
	. = ..()

/obj/projectile/bullet/cannonball/biggest_one
	name = "\"The Biggest One\""
	icon_state = "biggest_one"
	damage = 70 //low pierce

/obj/projectile/bullet/cannonball/biggest_one/on_hit(atom/target, blocked = FALSE)
	if(projectile_piercing == NONE)
		explosion(target,devastation_range = zas_settings.maxex_devastation_range, heavy_impact_range = zas_settings.maxex_heavy_range, light_impact_range = zas_settings.maxex_light_range, flash_range = zas_settings.maxex_flash_range, explosion_cause = src)
	. = ..()

/obj/projectile/bullet/cannonball/trashball
	name = "trashball"
	icon_state = "trashball"
	damage = 90 //better than the biggest one but no explosion, so kinda just a worse normal cannonball
