-- ░██████╗░█████╗░██╗░░░██╗██████╗░███████╗░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗
-- ██╔════╝██╔══██╗██║░░░██║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
-- ╚█████╗░██║░░╚═╝██║░░░██║██████╦╝█████╗░░╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░
-- ░╚═══██╗██║░░██╗██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗
-- ██████╔╝╚█████╔╝╚██████╔╝██████╦╝███████╗██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝
-- ╚═════╝░░╚════╝░░╚═════╝░╚═════╝░╚══════╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░   

Config = {}

Config.Locale = 'en' -- de, es, fr, dk and en

Config.Job = {
    Name = "gardener", -- Don´t Touch
    StartButton = 167, -- button to start the job. Standard F6
    VehiclePlate = "GARDEN", -- License plate Text
    StartLocation = vector4(-957.0, 327.68, 71.28, 275.48), -- Job entry point
    VehicleSpawn = vector4(-936.28, 330.64, 71.44, 276.84), -- Autospawn point
    VehicleDespawn = vector4(-943.52, 308.24, 71.2, 357.24), -- Car Despawn point
    VehicleModel = "utillitruck3", -- Vehicle model
    Payment = 500, -- Payment per task
    Tasks = {
        {
            name = "villa1",
            mainLocation = vector3(-1549.32, -86.08, 54.32),
            tasks = {
                { location = vector3(-1549.32, -86.08, 54.32), type = "check", time = 8000 },
                { location = vector3(-1574.76, -94.0, 54.08), type = "weed", time = 10000 },
                { location = vector3(-1585.12, -110.96, 54.16), type = "weed", time = 10000 },
                { location = vector3(-1562.84, -143.96, 55.2), type = "weed", time = 10000 },
                { location = vector3(-1558.44, -144.28, 55.08), type = "weed", time = 10000 },
                { location = vector3(-1564.24, -126.16, 54.32), type = "mow", time = 10000 },
                { location = vector3(-1549.48, -114.72, 54.32), type = "mow", time = 10000 },
                { location = vector3(-1529.8, -90.32, 54.32), type = "mow", time = 10000 }
            }
        },
        {
            name = "villa2",
            mainLocation = vector3(-866.52, 22.04, 47.44),
            tasks = {
                { location = vector3(-881.88, 22.68, 45.44), type = "check", time = 8000 }, 
                { location = vector3(-854.32, 19.96, 45.64), type = "weed", time = 10000 }, 
                { location = vector3(-857.2, 11.88, 44.96), type = "weed", time = 10000 }, 
                { location = vector3(-865.08, 18.4, 46.24), type = "weed", time = 10000 }, 
                { location = vector3(-879.12, 35.68, 48.96), type = "mow", time = 10000 }, 
                { location = vector3(-873.76, 46.32, 48.76), type = "mow", time = 10000 }, 
                { location = vector3(-865.52, 32.24, 48.24), type = "mow", time = 10000 }, 
            }
        },
        {
            name = "villa3",
            mainLocation = vector3(-1463.96, -33.24, 54.68),
            tasks = {
                { location = vector3(-1463.96, -33.24, 54.68), type = "check", time = 8000 },
                { location = vector3(-1458.84, -33.0, 54.64), type = "mow", time = 10000 }, 
                { location = vector3(-1465.36, -23.52, 54.64), type = "mow", time = 10000 }, 
                { location = vector3(-1470.0, -19.04, 54.64), type = "mow", time = 10000 }, 
                { location = vector3(-1452.6, -20.48, 54.68), type = "weed", time = 10000 }, 
                { location = vector3(-1457.28, -17.32, 54.72), type = "weed", time = 10000 }, 
                { location = vector3(-1451.12, -11.2, 54.64), type = "weed", time = 10000 },
            }
        },
        {
            name = "test",
            mainLocation = vector3(-854.16, -85.88, 37.84),
            tasks = {
                { location = vector3(-854.16, -85.88, 37.84), type = "check", time = 8000 },
                { location = vector3(-866.04, -85.72, 37.88), type = "weed", time = 10000 }, 
                { location = vector3(-870.76, -84.44, 37.88), type = "weed", time = 10000 }, 
                { location = vector3(-868.04, -79.88, 37.88), type = "weed", time = 10000 }, 
                { location = vector3(-863.92, -75.64, 37.92), type = "weed", time = 10000 }, 
                { location = vector3(-864.8, -70.44, 37.88), type = "weed", time = 10000 }, 
                { location = vector3(-858.56, -72.64, 37.84), type = "weed", time = 10000 }, 
            }
        }
    },    
    WorkClothes = {
        male = {
            components = {
                { component_id = 11, drawable = 168, texture = 0 }, -- T-shirt 1
                { component_id = 8, drawable = 20, texture = 0 }, -- Torso 1
                { component_id = 4, drawable = 63, texture = 0 }, -- Pants
                { component_id = 6, drawable = 12, texture = 6 }  -- Shoes
            },
            props = {}
        },
        female = {
            components = {
                { component_id = 11, drawable = 112, texture = 0 }, -- T-shirt 1
                { component_id = 4, drawable = 98, texture = 0 },  -- Pants
                { component_id = 6, drawable = 70, texture = 0 }   -- Shoes
            },
            props = {}
        }
    }
}

Translation = {
    ['de'] = {
        ['menu_name'] = 'O´Connor Landscaping',
        ['menu_task'] = 'Aufgabe ',
        ['clothe_on'] = 'Arbeitskleidung angezogen.',
        ['clothe_off'] = 'Arbeitskleidung ausgezogen.',
        ['spawn_err'] = 'Ein Fahrzeug blockiert den Spawnpunkt. Bitte entferne es zuerst.',
        ['job_main'] = 'Hauptpunkt',
        ['job_back'] = 'Fahre zum Hauptpunkt und beginne mit der Arbeit.',
        ['job_quit'] = 'Job beendet.',
        ['job_earn'] = 'Alle Aufgaben erledigt! Du hast $',
        ['job_earn2'] = ' verdient.',
        ['job_nexttask'] = 'Nächste Aufgabe',
        ['job_input1'] = 'Drücke ~INPUT_CONTEXT~, um die Arbeitskleidung anzuziehen.',
        ['job_input2'] = 'Drücke ~INPUT_DETONATE~, um die Arbeitskleidung auszuziehen.',
        ['job_clothe_err'] = 'Du musst die Arbeitskleidung anziehen, um den Job zu starten.',
        ['job_earn3'] = 'Aufgabe erledigt! Du hast $',
        ['job_car_back'] = 'Drücke ~INPUT_CONTEXT~, um das Fahrzeug abzugeben.',
        ['job_car_success'] = 'Fahrzeug erfolgreich abgegeben.',
        ['job_car'] = 'Jobfahrzeug',
        ['job_car_back_nof'] = 'Fahrzeug zurückgegeben.',
    },
    ['en'] = {
        ['menu_name'] = 'O´Connor Landscaping',
        ['menu_task'] = 'Task ',
        ['clothe_on'] = 'Work clothes put on.',
        ['clothe_off'] = 'Work clothes taken off.',
        ['spawn_err'] = 'A vehicle is blocking the spawn point. Please remove it first.',
        ['job_main'] = 'Main point',
        ['job_back'] = 'Drive back to the main point and start working.',
        ['job_quit'] = 'Job ended.',
        ['job_earn'] = 'All tasks completed! You earned $',
        ['job_earn2'] = '.',
        ['job_nexttask'] = 'Next task',
        ['job_input1'] = 'Press ~INPUT_CONTEXT~ to put on work clothes.',
        ['job_input2'] = 'Press ~INPUT_DETONATE~ to take off work clothes.',
        ['job_clothe_err'] = 'You must put on work clothes to start the job.',
        ['job_earn3'] = 'Task completed! You earned $',
        ['job_car_back'] = 'Press ~INPUT_CONTEXT~ to return the vehicle.',
        ['job_car_success'] = 'Vehicle successfully returned.',
        ['job_car'] = 'Job vehicle',
        ['job_car_back_nof'] = 'Vehicle returned.',
    },
    ['fr'] = {
        ['menu_name'] = 'O´Connor Landscaping',
        ['menu_task'] = 'Tâche ',
        ['clothe_on'] = 'Vêtements de travail enfilés.',
        ['clothe_off'] = 'Vêtements de travail retirés.',
        ['spawn_err'] = 'Un véhicule bloque le point de spawn. Veuillez le déplacer d\'abord.',
        ['job_main'] = 'Point principal',
        ['job_back'] = 'Retournez au point principal et commencez à travailler.',
        ['job_quit'] = 'Job terminé.',
        ['job_earn'] = 'Toutes les tâches terminées ! Vous avez gagné $',
        ['job_earn2'] = '.',
        ['job_nexttask'] = 'Tâche suivante',
        ['job_input1'] = 'Appuyez sur ~INPUT_CONTEXT~ pour enfiler les vêtements de travail.',
        ['job_input2'] = 'Appuyez sur ~INPUT_DETONATE~ pour retirer les vêtements de travail.',
        ['job_clothe_err'] = 'Vous devez enfiler les vêtements de travail pour commencer le job.',
        ['job_earn3'] = 'Tâche terminée ! Vous avez gagné $',
        ['job_car_back'] = 'Appuyez sur ~INPUT_CONTEXT~ pour retourner le véhicule.',
        ['job_car_success'] = 'Véhicule retourné avec succès.',
        ['job_car'] = 'Véhicule de travail',
        ['job_car_back_nof'] = 'Véhicule retourné.',
    },
    ['es'] = {
        ['menu_name'] = 'O´Connor Landscaping',
        ['menu_task'] = 'Tarea ',
        ['clothe_on'] = 'Ropa de trabajo puesta.',
        ['clothe_off'] = 'Ropa de trabajo quitada.',
        ['spawn_err'] = 'Un vehículo está bloqueando el punto de aparición. Por favor, retíralo primero.',
        ['job_main'] = 'Punto principal',
        ['job_back'] = 'Conduce de vuelta al punto principal y comienza a trabajar.',
        ['job_quit'] = 'Trabajo terminado.',
        ['job_earn'] = '¡Todas las tareas completadas! Has ganado $',
        ['job_earn2'] = '.',
        ['job_nexttask'] = 'Siguiente tarea',
        ['job_input1'] = 'Presiona ~INPUT_CONTEXT~ para ponerte la ropa de trabajo.',
        ['job_input2'] = 'Presiona ~INPUT_DETONATE~ para quitarte la ropa de trabajo.',
        ['job_clothe_err'] = 'Debes ponerte la ropa de trabajo para comenzar el trabajo.',
        ['job_earn3'] = '¡Tarea completada! Has ganado $',
        ['job_car_back'] = 'Presiona ~INPUT_CONTEXT~ para devolver el vehículo.',
        ['job_car_success'] = 'Vehículo devuelto con éxito.',
        ['job_car'] = 'Vehículo de trabajo',
        ['job_car_back_nof'] = 'Vehículo devuelto.',
    },
    ['dk'] = {
        ['menu_name'] = 'O´Connor Landscaping',
        ['menu_task'] = 'Opgave ',
        ['clothe_on'] = 'Arbejdstøj påtaget.',
        ['clothe_off'] = 'Arbejdstøj aftaget.',
        ['spawn_err'] = 'Et køretøj blokerer spawn-punktet. Fjern det venligst først.',
        ['job_main'] = 'Hovedpunkt',
        ['job_back'] = 'Kør tilbage til hovedpunktet og begynd at arbejde.',
        ['job_quit'] = 'Job afsluttet.',
        ['job_earn'] = 'Alle opgaver gennemført! Du har tjent $',
        ['job_earn2'] = '.',
        ['job_nexttask'] = 'Næste opgave',
        ['job_input1'] = 'Tryk ~INPUT_CONTEXT~ for at tage arbejdstøj på.',
        ['job_input2'] = 'Tryk ~INPUT_DETONATE~ for at tage arbejdstøj af.',
        ['job_clothe_err'] = 'Du skal have arbejdstøj på for at starte jobbet.',
        ['job_earn3'] = 'Opgave gennemført! Du har tjent $',
        ['job_car_back'] = 'Tryk ~INPUT_CONTEXT~ for at returnere køretøjet.',
        ['job_car_success'] = 'Køretøj returneret succesfuldt.',
        ['job_car'] = 'Jobkøretøj',
        ['job_car_back_nof'] = 'Køretøj returneret.',
    },
}