//Procedures in this file: Generic ribcage opening steps, Removing alien embryo, Fixing internal organs.
//////////////////////////////////////////////////////////////////
//				GENERIC	RIBCAGE SURGERY							//
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//	generic ribcage surgery step datum
//////////////////////////////////////////////////////////////////
/datum/surgery_step/open_encased
	name = "Saw through bone"
	desc = "Surgerically fractures the bones of a patient's limb, granting access to any organs underneath."
	allowed_tools = list(
		TOOL_SAW = 100,
		/obj/item/knife = 50,
		/obj/item/hatchet = 75
	)
	can_infect = 1
	blood_level = 1
	min_duration = 5 SECONDS
	max_duration = 7 SECONDS
	shock_level = 60
	delicate = 1
	surgery_candidate_flags = SURGERY_NO_ROBOTIC | SURGERY_NO_STUMP | SURGERY_NEEDS_RETRACTED
	strict_access_requirement = TRUE

/datum/surgery_step/open_encased/assess_bodypart(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/affected = ..()
	if(affected && affected.encased)
		return affected

/datum/surgery_step/open_encased/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/affected = target.get_bodypart(target_zone)
	user.visible_message(span_notice("[user] begins to cut through [target]'s [affected.encased] with [tool]."))
	..()

/datum/surgery_step/open_encased/succeed_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/affected = target.get_bodypart(target_zone)
	user.visible_message(span_notice("[user] has cut [target]'s [affected.encased] open with [tool]."))
	affected.break_bones()
	..()

/datum/surgery_step/open_encased/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/affected = target.get_bodypart(target_zone)
	user.visible_message(span_warning("[user]'s hand slips, cracking [target]'s [affected.encased] with \the [tool]!"))
	affected.receive_damage(15, sharpness = SHARP_EDGED|SHARP_POINTY)
	affected.break_bones()
	..()
