-- NexFit — Jalon 3 : seed exercices (72) + alternatives + programmes prédéfinis
-- Contenu versionné : toute modification = nouvelle migration.

-- ============================================================
-- EXERCICES
-- ============================================================
insert into public.exercises (name_fr, name_en, muscle_group, movement_type, equipment, difficulty, exercise_type, instructions_fr, instructions_en, common_mistakes_fr, common_mistakes_en) values

-- CHEST (12)
('Développé couché barre','Barbell Bench Press','chest','compound','barbell','intermediate','free_weights',
$$["Allonge-toi sur le banc, pieds ancrés au sol.","Saisis la barre légèrement plus large que les épaules.","Descends la barre jusqu'au milieu de la poitrine.","Pousse vers le haut en gardant les omoplates serrées."]$$::jsonb,
$$["Lie on the bench with feet planted on the floor.","Grip the bar slightly wider than shoulder width.","Lower the bar to mid-chest.","Press up while keeping shoulder blades retracted." ]$$::jsonb,
$$["Ne fais pas rebondir la barre sur la poitrine.","Garde les fessiers en contact avec le banc."]$$,
$$["Do not bounce the bar off your chest.","Keep your glutes in contact with the bench." ]$$),

('Développé incliné barre','Incline Barbell Press','chest','compound','barbell','intermediate','free_weights',
$$["Régle l'inclinaison à 30-45°.","Saisis la barre un peu plus large que les épaules.","Descends la barre vers le haut de la poitrine.","Pousse en contrôlant la descente."]$$::jsonb,
$$["Set the incline to 30-45 degrees.","Grip the bar slightly wider than shoulders.","Lower the bar to the upper chest.","Press up while controlling the descent."]$$::jsonb,
$$["Évite une inclinaison trop forte qui sollicite trop les épaules."]$$,
$$["Avoid too steep an incline that shifts too much work to the shoulders."]$$),

('Développé couché haltères','Dumbbell Bench Press','chest','compound','dumbbell','beginner','free_weights',
$$["Allonge-toi avec un haltère dans chaque main.","Descends les haltères sur les côtés de la poitrine.","Pousse vers le haut sans les cogner.","Contrôle la descente sur 2 secondes."]$$::jsonb,
$$["Lie down with a dumbbell in each hand.","Lower the dumbbells to the sides of your chest.","Press up without clashing them.","Control the descent for 2 seconds."]$$::jsonb,
$$["Ne laisse pas les coudes s'écarter à 90°."]$$,
$$["Do not let your elbows flare to 90 degrees."]$$),

('Développé incliné haltères','Incline Dumbbell Press','chest','compound','dumbbell','beginner','free_weights',
$$["Banc incliné à 30°.","Descends les haltères vers le haut de la poitrine.","Pousse en serrant légèrement les poignets."]$$::jsonb,
$$["Bench set to 30 degrees.","Lower the dumbbells to the upper chest.","Press up with wrists slightly stacked."]$$::jsonb,
$$["Ne surcharge pas : le contrôle est prioritaire."]$$,
$$["Do not overload: control comes first."]$$),

('Écarté poulie vis-à-vis','Cable Crossover','chest','isolation','cable','beginner','cable',
$$["Régle les poulies hautes.","Penche-toi légèrement en avant.","Ouvre les bras puis ramène les poignets ensemble devant la poitrine."]$$::jsonb,
$$["Set the pulleys high.","Lean slightly forward.","Open the arms then bring wrists together in front of the chest."]$$::jsonb,
$$["Ne transforme pas le mouvement en développé : garde les coudes légèrement pliés."]$$,
$$["Do not turn it into a press: keep elbows slightly bent."]$$),

('Papillon','Pec Deck','chest','isolation','machine','beginner','machine',
$$["Assis, dos bien plaqué.","Saisis les poignées.","Rapproche les coudes devant toi en contractant la poitrine."]$$::jsonb,
$$["Sit with your back fully against the pad.","Grab the handles.","Bring your elbows together in front, squeezing the chest."]$$::jsonb,
$$["Ne tire pas avec les épaules, isole la poitrine."]$$,
$$["Do not pull with your shoulders; isolate the chest."]$$),

('Pompes','Push-up','chest','compound','bodyweight','beginner','bodyweight',
$$["Plancher avant bras, corps aligné.","Descends jusqu'à ce que la poitrine frôle le sol.","Pousse en gardant le tronc gainé."]$$::jsonb,
$$["Hands under shoulders, body in a straight line.","Lower until your chest nearly touches the floor.","Press up while keeping the core braced."]$$::jsonb,
$$["Ne laisse pas le bas du dos s'affaisser."]$$,
$$["Do not let your lower back sag."]$$),

('Dips barre parallèles','Chest Dip','chest','compound','bodyweight','intermediate','bodyweight',
$$["Saisis les barres, penche le buste en avant.","Descends jusqu'à ce que les bras soient parallèles au sol.","Pousse en maintenant l'inclinaison."]$$::jsonb,
$$["Grip the bars, lean your torso forward.","Lower until your arms are parallel to the floor.","Press up while maintaining the lean."]$$::jsonb,
$$["Ne descends pas trop bas si tu as des douleurs d'épaule."]$$,
$$["Do not go too deep if you have shoulder pain."]$$),

('Écarté haltères','Dumbbell Fly','chest','isolation','dumbbell','beginner','free_weights',
$$["Allonge-toi, haltères au-dessus de la poitrine.","Ouvre les bras en arc de cercle, coudes pliés.","Ramène en serrant la poitrine."]$$::jsonb,
$$["Lie down, dumbbells above the chest.","Open your arms in an arc with bent elbows.","Bring them back by squeezing the chest."]$$::jsonb,
$$["Ne descends pas trop bas pour protéger l'épaule."]$$,
$$["Do not go too low to protect the shoulder."]$$),

('Développé décliené barre','Decline Bench Press','chest','compound','barbell','intermediate','free_weights',
$$["Banc décliené, pieds bloqués.","Descends la barre vers le bas de la poitrine.","Pousse en gardant les omoplates serrées."]$$::jsonb,
$$["Decline bench, feet secured.","Lower the bar toward the lower chest.","Press up keeping shoulder blades retracted."]$$::jsonb,
$$["Ne bloque pas ta respiration pendant la série."]$$,
$$["Do not hold your breath during the set."]$$),

('Presse poitrine','Machine Chest Press','chest','compound','machine','beginner','machine',
$$["Régle le siège à hauteur des épaules.","Pousse les poignées en avant sans verrouiller les coudes.","Contrôle le retour."]$$::jsonb,
$$["Set the seat so handles align with shoulders.","Press forward without locking the elbows.","Control the return."]$$::jsonb,
$$["Ne pousse pas avec les pieds pour tricher."]$$,
$$["Do not push with your legs to cheat."]$$),

('Pompes inclinées','Incline Push-up','chest','compound','bodyweight','beginner','bodyweight',
$$["Mains sur un banc ou une table.","Corps aligné des pieds à la tête.","Descends la poitrine vers le support."]$$::jsonb,
$$["Hands on a bench or table.","Body straight from feet to head.","Lower your chest toward the surface."]$$::jsonb,
$$["Idéal pour débuter avant les pompes au sol."]$$,
$$["Great for beginners before floor push-ups."]$$),

-- BACK (12)
('Soulevé de terre','Deadlift','back','compound','barbell','intermediate','free_weights',
$$["Pieds largeur de hanches, barre au milieu du pied.","Dos neutre, pince la barre.","Pousse le sol et soulève en gardant la barre contre les jambes."]$$::jsonb,
$$["Feet hip-width, bar over mid-foot.","Neutral back, grip the bar.","Push the floor and lift while keeping the bar against your legs."]$$::jsonb,
$$["Ne cambre pas le dos : c'est la cause n°1 de blessure."]$$,
$$["Do not round your back: it is the number one injury cause."]$$),

('Rowing barre','Barbell Row','back','compound','barbell','intermediate','free_weights',
$$["Penche le buste à 45°, dos neutre.","Tire la barre vers le bas du sternum.","Serre les omoplates puis redescends."]$$::jsonb,
$$["Hinge forward at 45 degrees, neutral back.","Pull the bar to your lower sternum.","Squeeze the shoulder blades, then lower."]$$::jsonb,
$$["Ne tords pas le tronc pour soulever plus lourd."]$$,
$$["Do not twist your torso to lift heavier."]$$),

('Tirage vertical','Lat Pulldown','back','compound','cable','beginner','cable',
$$["Assis, cuisses bloquées sous les coussinets.","Saisis la barre large, tire vers le haut de la poitrine.","Remonte lentement en étirant le dos."]$$::jsonb,
$$["Sit with thighs secured under pads.","Grab the bar wide, pull to the upper chest.","Return slowly, feeling the stretch."]$$::jsonb,
$$["Ne te penche pas en arrière pour tirer plus bas."]$$,
$$["Do not lean back to pull lower."]$$),

('Tractions','Pull-up','back','compound','bodyweight','intermediate','bodyweight',
$$["Saisis la barre, prise large paumes vers toi.","Tire les coudes vers le bas jusqu'à ce que le menton dépasse.","Descends en contrôlant."]$$::jsonb,
$$["Grip the bar wide, palms facing you.","Pull elbows down until chin clears the bar.","Lower under control."]$$::jsonb,
$$["Évite le kipping (élan) pour isoler le dos."]$$,
$$["Avoid kipping to keep the back doing the work."]$$),

('Tractions prise serrée','Chin-up','back','compound','bodyweight','intermediate','bodyweight',
$$["Prise pronation serrée ou supination.","Tire jusqu'à ce que le menton dépasse la barre."]$$::jsonb,
$$["Close overhand or underhand grip.","Pull until your chin clears the bar."]$$::jsonb,
$$["La supination engage davantage les biceps."]$$,
$$["Underhand grip engages the biceps more."]$$),

('Tirage bas assis','Seated Cable Row','back','compound','cable','beginner','cable',
$$["Assis, pieds sur la plateformes, dos droit.","Tire le guidon vers le nombril.","Serre les omoplates, remonte lentement."]$$::jsonb,
$$["Sit with feet on the platform, back straight.","Pull the handle to your navel.","Squeeze shoulder blades, return slowly."]$$::jsonb,
$$["Ne balance pas le tronc en tirant."]$$,
$$["Do not rock your torso to pull."]$$),

('Rowing unilatéral haltère','One-Arm Dumbbell Row','back','compound','dumbbell','beginner','free_weights',
$$["Un genou et une main sur le banc.","Tire l'haltère vers la hanche, coude près du corps."]$$::jsonb,
$$["One knee and one hand on the bench.","Pull the dumbbell toward your hip, elbow close to the body."]$$::jsonb,
$$["Ne tourne pas le buste en tirant."]$$,
$$["Do not rotate your torso as you pull."]$$),

('Tirage visage','Face Pull','back','isolation','cable','beginner','cable',
$$["Poulie haute, corde.","Tire vers le visage, coudes hauts.","Tourne les pouces en arrière en fin de mouvement."]$$::jsonb,
$$["High pulley, rope attachment.","Pull toward your face with high elbows.","Rotate thumbs back at the end."]$$::jsonb,
$$["Excellente exercice pour la santé des épaules."]$$,
$$["Excellent exercise for shoulder health."]$$),

('Shrug barre','Barbell Shrug','back','isolation','barbell','beginner','free_weights',
$$["Debout, barre en pronation.","Monte les épaules vers les oreilles.","Redescends lentement."]$$::jsonb,
$$["Standing, overhand grip.","Shrug shoulders up toward your ears.","Lower slowly."]$$::jsonb,
$$["Ne roule pas les épaules : monte droit."]$$,
$$["Do not roll the shoulders: shrug straight up."]$$),

('Soulevé de terre partiel','Rack Pull','back','compound','barbell','intermediate','free_weights',
$$["Barre sur les râteaux à hauteur des genoux.","Pince la barre, dos neutre, lève en verrouillant les hanches."]$$::jsonb,
$$["Bar on racks at knee height.","Grip the bar, neutral back, lift by locking the hips."]$$::jsonb,
$$["Alternative plus sûre au soulevé de terre complet."]$$,
$$["Safer alternative to the full deadlift."]$$),

('Bonjour','Good Morning','back','compound','barbell','intermediate','free_weights',
$$["Barre sur les trapèzes, pieds largeur hanches.","Penche le buste en avant avec le dos neutre.","Remonte en contractant les ischio-jambiers."]$$::jsonb,
$$["Bar on traps, feet hip-width.","Hinge forward with a neutral back.","Return by squeezing the hamstrings."]$$::jsonb,
$$["Charge légère : cet exercice sollicite le bas du dos."]$$,
$$["Light weight: this exercise stresses the lower back."]$$),

('Rowing appui poitrine','Chest-Supported Row','back','compound','machine','beginner','machine',
$$["Assis face au coussin, poitrine appuyée.","Tire les poignées en serrant les omoplates."]$$::jsonb,
$$["Sit against the pad, chest supported.","Pull the handles, squeezing the shoulder blades."]$$::jsonb,
$$["Idéal pour isoler le dos sans solliciter le bas du dos."]$$,
$$["Great for isolating the back without lower-back strain."]$$),

-- LEGS (14)
('Squat barre','Back Squat','legs','compound','barbell','intermediate','free_weights',
$$["Barre sur les trapèzes, pieds largeur épaules.","Descends en poussant les hanches vers l'arrière.","Parallèle ou plus bas si la mobilité le permet.","Pousse le sol pour remonter."]$$::jsonb,
$$["Bar on traps, feet shoulder-width.","Descend by pushing hips back.","Parallel or below if mobility allows.","Push the floor to stand up."]$$::jsonb,
$$["Ne laisse pas les genoux s'effondrer vers l'intérieur."]$$,
$$["Do not let your knees cave inward."]$$),

('Squat avant','Front Squat','legs','compound','barbell','advanced','free_weights',
$$["Barre sur les deltoïdes antérieurs, coudes hauts.","Descends torso bien vertical.","Pousse les coudes vers le haut en montant."]$$::jsonb,
$$["Bar on front delts, elbows high.","Descend with an upright torso.","Drive elbows up as you stand."]$$::jsonb,
$$["Nécessite une bonne mobilité de poignet et de thorax."]$$,
$$["Requires good wrist and thoracic mobility."]$$),

('Presse à cuisses','Leg Press','legs','compound','machine','beginner','machine',
$$["Assis, pieds au milieu de la plateforme à largeur épaules.","Descends jusqu'à 90° aux genoux.","Pousse sans verrouiller les genoux."]$$::jsonb,
$$["Seated, feet mid-platform shoulder-width.","Lower until knees reach about 90 degrees.","Press without locking the knees."]$$::jsonb,
$$["Ne descends pas si le bas du dos se décolle du siège."]$$,
$$["Do not lower if your lower back lifts off the seat."]$$),

('Fente marchante','Walking Lunge','legs','compound','dumbbell','intermediate','free_weights',
$$["Un haltère dans chaque main.","Fais un pas en avant et descends le genou arrière.","Pousse sur le talon avant pour avancer."]$$::jsonb,
$$["A dumbbell in each hand.","Step forward and lower the back knee.","Drive through the front heel to advance."]$$::jsonb,
$$["Garde le buste droit pendant le mouvement."]$$,
$$["Keep your torso upright throughout."]$$),

('Split squat bulgare','Bulgarian Split Squat','legs','compound','dumbbell','intermediate','free_weights',
$$["Pied arrière sur un banc, haltères aux côtés.","Descends verticalement jusqu'à ce que la cuisse arrière soit parallèle."]$$::jsonb,
$$["Rear foot on a bench, dumbbells at your sides.","Descend vertically until the rear thigh is parallel."]$$::jsonb,
$$["Place le pied avant assez loin pour ne pas surcharger le genou."]$$,
$$["Place the front foot far enough to spare the knee."]$$),

('Soulevé de terre roumain','Romanian Deadlift','legs','compound','barbell','intermediate','free_weights',
$$["Debout, barre contre les cuisses.","Pousse les hanches vers l'arrière, descends la barre le long des jambes.","Remonte en contractant les fessiers."]$$::jsonb,
$$["Standing, bar against thighs.","Push hips back, slide the bar down your legs.","Return by squeezing the glutes."]$$::jsonb,
$$["Garde le dos neutre : ne cambre pas en bas."]$$,
$$["Keep a neutral back: do not round at the bottom."]$$),

('Extension de cuisse','Leg Extension','legs','isolation','machine','beginner','machine',
$$["Assis, dos plaqué, chevilles sous le coussin.","Étends les genoux en contractant les quadriceps."]$$::jsonb,
$$["Seated, back flat, ankles under the pad.","Extend the knees, squeezing the quads."]$$::jsonb,
$$["Ne verrouille pas brutalement les genoux."]$$,
$$["Do not snap the knees into lockout."]$$),

('Flexion de cuisse couché','Lying Leg Curl','legs','isolation','machine','beginner','machine',
$$["Allongé face au coussin, chevilles derrière.","Flex les genoux en rapprochant les talons.","Redescends lentement."]$$::jsonb,
$$["Lie face down, ankles behind the pad.","Curl the heels toward your glutes.","Lower slowly."]$$::jsonb,
$$["Ne décolle pas les hanches du banc."]$$,
$$["Do not lift your hips off the bench."]$$),

('Mollets debout','Standing Calf Raise','legs','isolation','machine','beginner','machine',
$$["Épaules sous les coussinets, pieds à bord de la plateforme.","Monte sur la pointe des pieds, contracte en haut.","Redescends en étirant le mollet."]$$::jsonb,
$$["Shoulders under pads, balls of feet on the platform edge.","Rise onto your toes, squeeze at the top.","Lower to feel the stretch."]$$::jsonb,
$$["Amplitude complète : étirement en bas, contraction en haut."]$$,
$$["Full range: stretch at the bottom, squeeze at the top."]$$),

('Hip thrust','Hip Thrust','legs','compound','barbell','intermediate','free_weights',
$$["Dos contre un banc, barre sur les hanches.","Pousse les hanches vers le haut en contractant les fessiers.","Redescends en contrôlant."]$$::jsonb,
$$["Upper back on a bench, bar over hips.","Drive hips up, squeezing the glutes.","Lower under control."]$$::jsonb,
$$["Regarde vers l'avant pour protéger la nuque."]$$,
$$["Look forward to protect your neck."]$$),

('Squat goblet','Goblet Squat','legs','compound','dumbbell','beginner','free_weights',
$$["Tiens un haltère contre la poitrine, coudes vers le bas.","Descends en poussant les hanches vers l'arrière."]$$::jsonb,
$$["Hold a dumbbell at your chest, elbows down.","Descend by pushing hips back."]$$::jsonb,
$$["Excellente introduction au squat."]$$,
$$["Great introduction to the squat."]$$),

('Montée de marche','Step-Up','legs','compound','bodyweight','beginner','bodyweight',
$$["Pied entier sur une marche haute genou.","Pousse sur le talon pour monter.","Redescends en contrôlant."]$$::jsonb,
$$["Whole foot on a knee-height step.","Drive through the heel to step up.","Lower under control."]$$::jsonb,
$$["Évite de te propulser avec le pied arrière."]$$,
$$["Avoid pushing off with the back foot."]$$),

('Fente haltères','Dumbbell Lunge','legs','compound','dumbbell','beginner','free_weights',
$$["Haltères le long du corps.","Fais un pas en avant et descends le genou arrière proche du sol."]$$::jsonb,
$$["Dumbbells at your sides.","Step forward, lowering the back knee close to the floor."]$$::jsonb,
$$["Ne dépasse pas la pointe du pied avant avec le genou."]$$,
$$["Do not let the front knee travel past the toes."]$$),

-- SHOULDERS (10)
('Développé militaire','Overhead Press','shoulders','compound','barbell','intermediate','free_weights',
$$["Debout, barre au niveau des clavicules, serrer les fessiers.","Pousse la barre au-dessus de la tête sans cambrer.","Redescends en contrôlant."]$$::jsonb,
$$["Standing, bar at clavicles, brace glutes.","Press the bar overhead without arching.","Lower under control."]$$::jsonb,
$$["Ne cambre pas le bas du dos pour compenser."]$$,
$$["Do not arch the lower back to compensate."]$$),

('Développé haltères assis','Seated Dumbbell Press','shoulders','compound','dumbbell','beginner','free_weights',
$$["Assis, dossier à 85-90°.","Pousse les haltères au-dessus de la tête sans les cogner."]$$::jsonb,
$$["Seated, backrest at 85-90 degrees.","Press the dumbbells overhead without clashing."]$$::jsonb,
$$["Ne pousse pas avec les jambes si assis."]$$,
$$["Do not push with your legs when seated."]$$),

('Élévations latérales','Lateral Raise','shoulders','isolation','dumbbell','beginner','free_weights',
$$["Haltères le long du corps, coudes légèrement pliés.","Monte les bras jusqu'à hauteur des épaules.","Redescends lentement."]$$::jsonb,
$$["Dumbbells at your sides, elbows slightly bent.","Raise arms to shoulder height.","Lower slowly."]$$::jsonb,
$$["Charge légère : la technique prime."]$$,
$$["Light weight: technique comes first."]$$),

('Élévations frontales','Front Raise','shoulders','isolation','dumbbell','beginner','free_weights',
$$["Haltères devant les cuisses, paumes vers le bas.","Monte un ou deux bras à hauteur des épaules."]$$::jsonb,
$$["Dumbbells in front of thighs, palms down.","Raise one or both arms to shoulder height."]$$::jsonb,
$$["Ne balance pas le corps pour élever la charge."]$$,
$$["Do not swing your body to lift the weight."]$$),

('Oiseau haltères','Rear Delt Fly','shoulders','isolation','dumbbell','beginner','free_weights',
$$["Penche le buste presque horizontal.","Ouvre les bras en arc de cercle en contractant les arrière d'épaules."]$$::jsonb,
$$["Bend forward until nearly horizontal.","Open the arms in an arc, squeezing the rear delts."]$$::jsonb,
$$["Regarde le sol pour garder la nuque neutre."]$$,
$$["Look at the floor to keep the neck neutral."]$$),

('Développé Arnold','Arnold Press','shoulders','compound','dumbbell','intermediate','free_weights',
$$["Assis, paumes face à toi devant la poitrine.","Tourne les poignets en poussant au-dessus de la tête."]$$::jsonb,
$$["Seated, palms facing you at chest level.","Rotate the wrists as you press overhead."]$$::jsonb,
$$["Mouvement fluide : ne sépare pas trop les deux phases."]$$,
$$["Smooth movement: do not overly separate the two phases."]$$),

('Tirage menton','Upright Row','shoulders','compound','barbell','intermediate','free_weights',
$$["Barre en pronation, largeur serrée.","Tire la barre vers le menton, coudes au-dessus des poignets."]$$::jsonb,
$$["Narrow overhand grip.","Pull the bar to your chin, elbows above wrists."]$$::jsonb,
$$["Si tu as des douleurs d'épaule, remplace par des élévations latérales."]$$,
$$["If you have shoulder pain, swap for lateral raises."]$$),

('Élévations latérales poulie','Cable Lateral Raise','shoulders','isolation','cable','beginner','cable',
$$["Poulie basse, une main sur la hanche.","Monte le bras à hauteur des épaules en contrôlant."]$$::jsonb,
$$["Low pulley, one hand on your hip.","Raise the arm to shoulder height under control."]$$::jsonb,
$$["Tension constante grâce à la poulie : excellent pour la time under tension."]$$,
$$["Constant cable tension: great for time under tension."]$$),

('Pompes pike','Pike Push-up','shoulders','compound','bodyweight','intermediate','bodyweight',
$$["Position de pompe mais hanches hautes, corps en V.","Descends le sommet de la tête vers le sol."]$$::jsonb,
$$["Push-up position but hips high, body in a V.","Lower the crown of your head toward the floor."]$$::jsonb,
$$["Prépare aux handstands et au développé militaire."]$$,
$$["Great prep for handstands and the overhead press."]$$),

('Presse épaules','Machine Shoulder Press','shoulders','compound','machine','beginner','machine',
$$["Assis, poignées à hauteur des épaules.","Pousse vers le haut sans verrouiller les coudes."]$$::jsonb,
$$["Seated, handles at shoulder height.","Press up without locking the elbows."]$$::jsonb,
$$["Ajuste le siège pour que les poignées soient au niveau des épaules."]$$,
$$["Adjust the seat so handles align with shoulders."]$$),

-- ARMS (12)
('Curl barre','Barbell Curl','arms','isolation','barbell','beginner','free_weights',
$$["Debout, barre en supination largeur épaules.","Coudes collés au corps, plie jusqu'à contraction."]$$::jsonb,
$$["Standing, shoulder-width underhand grip.","Elbows pinned to sides, curl to full contraction."]$$::jsonb,
$$["Ne balance pas le buste pour soulever la barre."]$$,
$$["Do not swing your torso to lift the bar."]$$),

('Curl haltères','Dumbbell Curl','arms','isolation','dumbbell','beginner','free_weights',
$$["Haltères le long du corps, paumes vers l'avant.","Plie un ou deux bras en gardant les coudes fixés."]$$::jsonb,
$$["Dumbbells at your sides, palms forward.","Curl one or both arms keeping elbows fixed."]$$::jsonb,
$$["Contrôle la descente : c'est là que le muscle travaille le plus."]$$,
$$["Control the lowering phase: that is where the muscle works most."]$$),

('Curl marteau','Hammer Curl','arms','isolation','dumbbell','beginner','free_weights',
$$["Haltères en prise neutre (paumes face au corps).","Plie en gardant les poignets droits."]$$::jsonb,
$$["Dumbbells with a neutral grip (palms facing body).","Curl keeping wrists straight."]$$::jsonb,
$$["Cible le brachial et les avant-bras."]$$,
$$["Targets the brachialis and forearms."]$$),

('Curl pupitre','Preacher Curl','arms','isolation','machine','intermediate','machine',
$$["Assis, bras posés sur le coussin incliné.","Monte la barre sans bouger les épaules."]$$::jsonb,
$$["Seated, arms on the angled pad.","Curl without moving your shoulders."]$$::jsonb,
$$["Élimine le momentum : excellent pour l'isolation."]$$,
$$["Eliminates momentum: excellent for isolation."]$$),

('Poulie triceps','Tricep Pushdown','arms','isolation','cable','beginner','cable',
$$["Poulie haute, corde ou barre.","Pousse vers le bas en gardant les coudes près du corps."]$$::jsonb,
$$["High pulley, rope or bar.","Push down keeping elbows close to the body."]$$::jsonb,
$$["Ne te penche pas en avant pour tricher."]$$,
$$["Do not lean forward to cheat."]$$),

('Extension nuque','Skull Crusher','arms','isolation','barbell','intermediate','free_weights',
$$["Allongé, barre au-dessus de la poitrine.","Plie les coudes pour descendre la barre vers le front."]$$::jsonb,
$$["Lying down, bar above chest.","Bend the elbows to lower the bar toward your forehead."]$$::jsonb,
$$["Garde les coudes serrés et fixes."]$$,
$$["Keep elbows tight and fixed."]$$),

('Extension triceps au-dessus de la tête','Overhead Tricep Extension','arms','isolation','cable','beginner','cable',
$$["Poulie moyenne, corde derrière la tête.","Étends les bras vers le haut sans écarter les coudes."]$$::jsonb,
$$["Mid pulley, rope behind the head.","Extend arms overhead without flaring elbows."]$$::jsonb,
$$["Étire le long triceps grâce à cette position."]$$,
$$["Stretches the long head of the triceps."]$$),

('Développé serré','Close-Grip Bench Press','arms','compound','barbell','intermediate','free_weights',
$$["Prise plus étroite que le développé couché.","Descends la barre au bas de la poitrine.","Pousse en serrant les triceps."]$$::jsonb,
$$["Grip narrower than the bench press.","Lower the bar to the lower chest.","Press, squeezing the triceps."]$$::jsonb,
$$["Prise trop serrée peut blesser les poignets : ajuste."]$$,
$$["Too narrow a grip can hurt the wrists: adjust."]$$),

('Curl poulie','Cable Curl','arms','isolation','cable','beginner','cable',
$$["Poulie basse, barre droite.","Coudes fixés, plie jusqu'à contraction."]$$::jsonb,
$$["Low pulley, straight bar.","Elbows fixed, curl to contraction."]$$::jsonb,
$$["Tension constante sur toute l'amplitude."]$$,
$$["Constant tension through the full range."]$$),

('Machine dips','Tricep Dip Machine','arms','compound','machine','beginner','machine',
$$["Assis, poignées de chaque côté.","Pousse vers le bas sans verrouiller les coudes."]$$::jsonb,
$$["Seated, handles on each side.","Push down without locking the elbows."]$$::jsonb,
$$["Alternative plus sûre aux dips aux barres parallèles."]$$,
$$["Safer alternative to parallel-bar dips."]$$),

('Curl concentration','Concentration Curl','arms','isolation','dumbbell','beginner','free_weights',
$$["Assis, coude appuyé contre l'intérieur de la cuisse.","Plie lentement en contractant le biceps."]$$::jsonb,
$$["Seated, elbow braced against the inner thigh.","Curl slowly, squeezing the biceps."]$$::jsonb,
$$["Amplitude lente et contrôlée."]$$,
$$["Slow, controlled range of motion."]$$),

('Kickback triceps','Tricep Kickback','arms','isolation','dumbbell','beginner','free_weights',
$$["Penche le buste, bras long le long du corps.","Étends le coude en arrière jusqu'à contraction."]$$::jsonb,
$$["Lean forward, arm long at your side.","Extend the elbow back to full contraction."]$$::jsonb,
$$["Garde le bras immobile : seul l'avant-bras bouge."]$$,
$$["Keep the upper arm still: only the forearm moves."]$$),

-- CORE (10)
('Gainage','Plank','core','isometric','bodyweight','beginner','bodyweight',
$$["Coudes sous les épaules, corps aligné.","Contracte les abdominaux et les fessiers.","Tiens la position en respirant."]$$::jsonb,
$$["Elbows under shoulders, body aligned.","Brace abs and glutes.","Hold while breathing."]$$::jsonb,
$$["Ne laisse pas les hanches monter ou descendre."]$$,
$$["Do not let your hips rise or sag."]$$),

('Relevé de jambes suspendu','Hanging Leg Raise','core','compound','bodyweight','intermediate','bodyweight',
$$["Suspendu à la barre, bras tendus.","Monte les jambes jusqu'à parallèle au sol ou plus haut."]$$::jsonb,
$$["Hanging from the bar, arms straight.","Raise legs to parallel or higher."]$$::jsonb,
$$["Évite le balancement : contrôle le mouvement."]$$,
$$["Avoid swinging: control the movement."]$$),

('Crunch poulie','Cable Crunch','core','isolation','cable','beginner','cable',
$$["À genoux face à la poulie haute, corde derrière la tête.","Plie le tronc en rapprochant les coudes des genoux."]$$::jsonb,
$$["Kneeling at a high pulley, rope behind head.","Curl the torso, bringing elbows toward knees."]$$::jsonb,
$$["Seul le tronc bouge : ne tire pas avec les bras."]$$,
$$["Only the torso moves: do not pull with your arms."]$$),

('Twist russe','Russian Twist','core','isolation','bodyweight','beginner','bodyweight',
$$["Assis, buste incliné, pieds décollés optionnels.","Tourne le tronc de gauche à droite."]$$::jsonb,
$$["Seated, torso leaned back, feet optionally lifted.","Rotate the torso from side to side."]$$::jsonb,
$$["Contrôle la rotation, ne va pas trop vite."]$$,
$$["Control the rotation, do not go too fast."]$$),

('Roue abdominale','Ab Wheel Rollout','core','compound','bodyweight','advanced','bodyweight',
$$["À genoux, roue devant toi.","Roule en avant en gardant le tronc gainé.","Revient en contractant les abdominaux."]$$::jsonb,
$$["Kneeling, wheel in front.","Roll forward keeping the core braced.","Return by contracting the abs."]$$::jsonb,
$$["Ne cambre pas le bas du dos en avançant."]$$,
$$["Do not arch the lower back as you roll out."]$$),

('Crunch bicyclette','Bicycle Crunch','core','isolation','bodyweight','beginner','bodyweight',
$$["Allongé, mains derrière la tête.","Alterne coude opposé et genou."]$$::jsonb,
$$["Lying down, hands behind the head.","Alternate opposite elbow to knee."]$$::jsonb,
$$["Ne tire pas sur la nuque avec les mains."]$$,
$$["Do not pull on your neck with your hands."]$$),

('Gainage latéral','Side Plank','core','isometric','bodyweight','beginner','bodyweight',
$$["Allongé sur le côté, coude sous l'épaule.","Monte les hanches en gardant le corps aligné."]$$::jsonb,
$$["On your side, elbow under shoulder.","Lift hips keeping the body aligned."]$$::jsonb,
$$["Fais des deux côtés pour l'équilibre."]$$,
$$["Do both sides for balance."]$$),

('Dead Bug','Dead Bug','core','isometric','bodyweight','beginner','bodyweight',
$$["Allongé sur le dos, bras vers le haut, genoux à 90°.","Étends bras et jambes opposés en gardant le dos plaqué."]$$::jsonb,
$$["On your back, arms up, knees at 90 degrees.","Extend opposite arm and leg keeping the back flat."]$$::jsonb,
$$["Le bas du dos reste collé au sol."]$$,
$$["Keep the lower back pressed to the floor."]$$),

('Grimpeur','Mountain Climber','core','compound','bodyweight','beginner','bodyweight',
$$["Position de pompe.","Alterne les genoux vers la poitrine rapidement."]$$::jsonb,
$$["Push-up position.","Alternate driving knees to the chest quickly."]$$::jsonb,
$$["Garde les hanches basses pendant le mouvement."]$$,
$$["Keep the hips low during the movement."]$$),

('Pression Pallof','Pallof Press','core','isometric','cable','intermediate','cable',
$$["Debout de profil à la poulie, corde au niveau de la poitrine.","Pousse le guidon devant toi sans laisser le tronc tourner."]$$::jsonb,
$$["Standing sideways to the pulley, rope at chest height.","Press the handle forward without letting the torso rotate."]$$::jsonb,
$$["Excellent pour la stabilité du tronc."]$$,
$$["Excellent for core stability."]$$);


-- ============================================================
-- ALTERNATIVES (substitution selon matériel)
-- ============================================================
insert into public.exercise_alternatives (exercise_id, alternative_id, reason_fr, reason_en)
select e1.id, e2.id, r.reason_fr, r.reason_en
from (values
  ('Barbell Bench Press','Dumbbell Bench Press','Pas de barre disponible : les haltères reproduisent le mouvement.','No barbell available: dumbbells replicate the movement.'),
  ('Incline Barbell Press','Incline Dumbbell Press','Pas de barre : haltères inclinés équivalents.','No barbell: incline dumbbells are equivalent.'),
  ('Barbell Row','One-Arm Dumbbell Row','Sans barre : le rowing unilatéral travaille le même dos.','Without a barbell: one-arm row hits the same back muscles.'),
  ('Lat Pulldown','Pull-up','Tu progresses vers les traction si la machine n est pas libre.','Progress toward pull-ups if the machine is busy.'),
  ('Pull-up','Lat Pulldown','Si les traction sont trop difficiles, le tirage vertical allège la charge.','If pull-ups are too hard, lat pulldown reduces the load.'),
  ('Back Squat','Goblet Squat','Sans rack : le squat goblet avec haltère suffit.','Without a rack: a dumbbell goblet squat works.'),
  ('Back Squat','Leg Press','Alternative articulairement plus douce pour les genoux.','Joint-friendlier alternative for the knees.'),
  ('Front Squat','Back Squat','Si la mobilité de poignet bloque, passe en squat arrière.','If wrist mobility limits you, switch to the back squat.'),
  ('Deadlift','Romanian Deadlift','Version plus simple et moins technique du soulevé de terre.','Simpler, less technical version of the deadlift.'),
  ('Deadlift','Rack Pull','Pour réduire l amplitude tout en chargeant lourd.','To reduce range of motion while lifting heavy.'),
  ('Overhead Press','Seated Dumbbell Press','Version plus stable et accessible des épaules.','More stable, accessible shoulder press.'),
  ('Barbell Curl','Dumbbell Curl','Sans barre : les haltères permettent le même travail des biceps.','Without a barbell: dumbbells train the biceps the same way.'),
  ('Tricep Pushdown','Overhead Tricep Extension','Si la poulie haute est occupée, l extension au-dessus de la tête cible le même muscle.','If the high pulley is busy, the overhead extension hits the same muscle.'),
  ('Cable Crossover','Dumbbell Fly','Sans poulie : l écarté haltères reproduit l écarté.','Without cables: the dumbbell fly replicates the crossover.'),
  ('Pec Deck','Dumbbell Fly','Si la machine est occupée, l écarté haltères fait le même travail d isolation.','If the machine is busy, dumbbell flyes isolate the chest similarly.'),
  ('Leg Press','Goblet Squat','Sans machine : le squat goblet travaille les jambes efficacement.','Without a machine: the goblet squat trains legs effectively.'),
  ('Bulgarian Split Squat','Walking Lunge','Version plus simple et mobile des jambes.','Simpler, more mobile leg option.'),
  ('Hanging Leg Raise','Bicycle Crunch','Sans barre de traction : le crunch bicyclette cible les abdominaux.','Without a pull-up bar: bicycle crunches target the abs.'),
  ('Ab Wheel Rollout','Dead Bug','Version plus sûre et progressive pour les abdominaux.','Safer, progressive option for the core.'),
  ('Machine Chest Press','Push-up','Sans machine : les pompes chargent la poitrine avec le poids du corps.','Without a machine: push-ups load the chest with bodyweight.'),
  ('Close-Grip Bench Press','Tricep Dip Machine','Si la barre est chargée, la machine dips isole les triceps.','If the bar is loaded, the dip machine isolates the triceps.')
) as r(ex1, ex2, reason_fr, reason_en)
join public.exercises e1 on e1.name_en = r.ex1
join public.exercises e2 on e2.name_en = r.ex2;

-- ============================================================
-- PROGRAMMES PRÉDÉFINIS
-- ============================================================
insert into public.programs (id, name_fr, name_en, description_fr, description_en, split_type, days_per_week, level, goal, source, is_public) values
('a0000000-0000-4000-8000-000000000001','Full Body 3 jours','Full Body 3 Days','Programme complet 3 séances par semaine, idéal pour un retour à l entraînement.','Complete 3-session-per-week program, ideal for returning to training.','full_body',3,'beginner','hypertrophy','predefined',true),
('a0000000-0000-4000-8000-000000000002','Push / Pull / Legs 6 jours','Push / Pull / Legs 6 Days','Division classique 6 jours pour un volume d entraînement élevé.','Classic 6-day split for high training volume.','ppl',6,'intermediate','hypertrophy','predefined',true),
('a0000000-0000-4000-8000-000000000003','Upper / Lower 4 jours','Upper / Lower 4 Days','Équilibre entre fréquence et récupération sur 4 séances.','Balance of frequency and recovery across 4 sessions.','upper_lower',4,'intermediate','hypertrophy','predefined',true);

-- ============================================================
-- PROGRAMMES PRÉDÉFINIS — jours
-- ============================================================
insert into public.program_days (program_id, day_index, name_fr, name_en) values
('a0000000-0000-4000-8000-000000000001',0,'Full Body A','Full Body A'),
('a0000000-0000-4000-8000-000000000001',1,'Full Body B','Full Body B'),
('a0000000-0000-4000-8000-000000000001',2,'Full Body C','Full Body C'),
('a0000000-0000-4000-8000-000000000002',0,'Push A','Push A'),
('a0000000-0000-4000-8000-000000000002',1,'Pull A','Pull A'),
('a0000000-0000-4000-8000-000000000002',2,'Legs A','Legs A'),
('a0000000-0000-4000-8000-000000000002',3,'Push B','Push B'),
('a0000000-0000-4000-8000-000000000002',4,'Pull B','Pull B'),
('a0000000-0000-4000-8000-000000000002',5,'Legs B','Legs B'),
('a0000000-0000-4000-8000-000000000003',0,'Upper A','Upper A'),
('a0000000-0000-4000-8000-000000000003',1,'Lower A','Lower A'),
('a0000000-0000-4000-8000-000000000003',2,'Upper B','Upper B'),
('a0000000-0000-4000-8000-000000000003',3,'Lower B','Lower B');

-- ============================================================
-- PROGRAMMES PRÉDÉFINIS — exercices
-- ============================================================
insert into public.program_exercises (program_day_id, exercise_id, order_index, target_sets, target_reps, rest_seconds)
select pd.id, e.id, v.ord::int, v.sets::int, v.reps::text, v.rest::int
from (values
  ('a0000000-0000-4000-8000-000000000001'::uuid,0,'Back Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000001'::uuid,0,'Barbell Bench Press',1,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000001'::uuid,0,'Barbell Row',2,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,0,'Overhead Press',3,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,0,'Plank',4,3,'30-60s',60),
  ('a0000000-0000-4000-8000-000000000001'::uuid,1,'Romanian Deadlift',0,4,'8-10',180),
  ('a0000000-0000-4000-8000-000000000001'::uuid,1,'Lat Pulldown',1,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,1,'Dumbbell Bench Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,1,'Leg Extension',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000001'::uuid,1,'Cable Crunch',4,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000001'::uuid,2,'Front Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000001'::uuid,2,'Chin-up',1,3,'AMRAP',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,2,'Seated Dumbbell Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000001'::uuid,2,'Lying Leg Curl',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000001'::uuid,2,'Face Pull',4,3,'15-20',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Barbell Bench Press',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Incline Dumbbell Press',1,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Overhead Press',2,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Lateral Raise',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Tricep Pushdown',4,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,0,'Overhead Tricep Extension',5,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Deadlift',0,4,'5',180),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Pull-up',1,3,'AMRAP',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Barbell Row',2,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Face Pull',3,3,'15-20',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Barbell Curl',4,3,'10-12',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,1,'Hammer Curl',5,3,'10-12',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Back Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Romanian Deadlift',1,3,'8-10',150),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Leg Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Lying Leg Curl',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Standing Calf Raise',4,4,'15-20',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,2,'Plank',5,3,'60s',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Incline Barbell Press',0,4,'8-10',150),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Machine Chest Press',1,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Arnold Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Cable Lateral Raise',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Skull Crusher',4,3,'10-12',90),
  ('a0000000-0000-4000-8000-000000000002'::uuid,3,'Close-Grip Bench Press',5,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Barbell Row',0,4,'8-10',150),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Lat Pulldown',1,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Chest-Supported Row',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Rear Delt Fly',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Preacher Curl',4,3,'10-12',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,4,'Concentration Curl',5,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Front Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Hip Thrust',1,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Walking Lunge',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Leg Extension',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Ab Wheel Rollout',4,3,'8-12',60),
  ('a0000000-0000-4000-8000-000000000002'::uuid,5,'Side Plank',5,3,'30-45s',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Barbell Bench Press',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Barbell Row',1,4,'8-10',150),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Overhead Press',2,3,'8-10',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Lat Pulldown',3,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Lateral Raise',4,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Barbell Curl',5,3,'10-12',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,0,'Tricep Pushdown',6,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,1,'Back Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000003'::uuid,1,'Romanian Deadlift',1,3,'8-10',150),
  ('a0000000-0000-4000-8000-000000000003'::uuid,1,'Leg Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,1,'Lying Leg Curl',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,1,'Standing Calf Raise',4,4,'15-20',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Incline Dumbbell Press',0,4,'8-10',150),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Chest-Supported Row',1,4,'8-10',150),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Seated Dumbbell Press',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Face Pull',3,3,'15-20',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Hammer Curl',4,3,'10-12',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,2,'Overhead Tricep Extension',5,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Front Squat',0,4,'6-8',180),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Hip Thrust',1,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Bulgarian Split Squat',2,3,'10-12',120),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Leg Extension',3,3,'12-15',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Ab Wheel Rollout',4,3,'8-12',60),
  ('a0000000-0000-4000-8000-000000000003'::uuid,3,'Hanging Leg Raise',5,3,'10-15',60)
) as v(program_id, day_index, ex, ord, sets, reps, rest)
join public.program_days pd on pd.program_id = v.program_id and pd.day_index = v.day_index::int
join public.exercises e on e.name_en = v.ex;
