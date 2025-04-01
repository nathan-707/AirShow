//
//  Planes.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import Foundation
import SwiftUI
import RealityKit





let doNotSetScale: SIMD3<Float> = SIMD3(0,0,0)

var audioControllers = [AudioPlaybackController]()


enum status { case active, notActive, experimental, cancelled }

enum origin { case america, russia, ussr, china, EuropeanConsortiumUKGermanyItalySpain, germany, uk, france, japan, turkey, naziGermany, austria, sweden, canada}

enum emitter { case smoke, blue, green, none, orangeJet, blueJet }

enum sound { case jetPlaneNoise, propellerPlaneNoise, largePlaneNoise, helicopterNoise, largePropellerPlaneNoise}
enum sortEnum { case accending, decending, free, speed }
enum animationType { case agile_fast_plane, agile_slow_plane, large_fast_plane, large_slow_plane, helicoper }




class Aircraft: Identifiable, Hashable {
    
    let name: String
    let description: String
    let origin: origin
    let yearIntroduced: Int
    let status: status
    let modelPathName: String
    let topSpeed: Int
    let Manufacturer: String
    let scale: SIMD3<Float>
    let emitter: emitter
    let sound: sound
    var mEntity: Entity
    var animationType: animationType
    var needToPurchase = false
    var offSet: SIMD3<Float> = [0,0,0]
    
    let id: UUID = UUID()
    
    
    init(name: String, origin: origin, yearIntroduced: Int,  status: status, Manufacturer: String, description: String, topSpeed: Int, modelPathName: String, scale: SIMD3<Float> = doNotSetScale, emitter: emitter = .smoke, sound: sound, mEntity: Entity = Entity(), animationType: animationType, needToPurchase: Bool = false, offSet: SIMD3<Float> = [0,50,0]) {
        self.name = name
        self.origin = origin
        self.status = status
        self.yearIntroduced = yearIntroduced
        self.Manufacturer = Manufacturer
        self.modelPathName = modelPathName
        self.description = description
        self.topSpeed = topSpeed
        self.scale = scale
        self.emitter = emitter
        self.sound = sound
        self.mEntity = Entity()
        self.animationType = animationType
        self.needToPurchase = needToPurchase
        self.offSet = offSet
    }
    
    static func == (lhs: Aircraft, rhs: Aircraft) -> Bool {
        return lhs.name == rhs.name && lhs.origin == rhs.origin && lhs.yearIntroduced == rhs.yearIntroduced && lhs.status == rhs.status && lhs.modelPathName == rhs.modelPathName && lhs.topSpeed == rhs.topSpeed && lhs.Manufacturer == rhs.Manufacturer
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(origin)
        hasher.combine(yearIntroduced)
        hasher.combine(status)
        hasher.combine(modelPathName)
        hasher.combine(topSpeed)
        hasher.combine(Manufacturer)
    }
}


let F35_Lightning2 = Aircraft(name: "F35 Lightning II", origin: .america, yearIntroduced: 2015, status: .active, Manufacturer: "Lockheed Martin", description: """
The F-35 Lightning II is a family of single-engine, stealth multirole fighters developed by Lockheed Martin, available in three variants: the F-35A for conventional takeoff and landing (CTOL), the F-35B for short takeoff and vertical landing (STOVL), and the F-35C for carrier-based operations. Designed for air superiority, ground attack, reconnaissance, and electronic warfare, the F-35 is one of the most advanced fighters in the world, combining stealth technology, advanced sensors, and network-centric capabilities to fulfill a wide range of mission roles.

The F-35 features a sleek, low-observable design with carefully angled surfaces, internal weapons bays, and radar-absorbent materials that minimize its radar cross-section and enhance its stealth. Powered by the Pratt & Whitney F135 engine, the F-35 achieves speeds of Mach 1.6 and delivers supermaneuverable performance. The F-35B variant includes a unique lift fan for vertical landing capabilities, enhancing its versatility for operations from shorter runways or aircraft carriers. 

The aircraft's advanced avionics include the AN/APG-81 AESA radar, which provides superior tracking, targeting, and situational awareness capabilities. Its Distributed Aperture System (DAS) gives pilots a 360-degree view of the battlefield, enhancing threat detection and situational awareness. The Electro-Optical Targeting System (EOTS) integrates infrared search, track, and laser targeting, providing exceptional precision for both air-to-air and air-to-ground engagements. The cockpit is equipped with a large touchscreen display and a helmet-mounted display system (HMDS), which projects crucial flight and targeting information onto the pilot’s visor, allowing for seamless control during complex missions.

It is Armed with an extensive range of weaponry, the F-35 maintains its stealth profile by carrying missiles and bombs internally. Its arsenal includes AIM-120 AMRAAM missiles for long-range air-to-air combat, AIM-9X Sidewinders for close engagements, and GBU-12 Paveway II laser-guided bombs for precision ground strikes. It can also deploy GBU-31 JDAM and other advanced munitions for diverse combat scenarios. The F-35A variant is fitted with a 25mm GAU-22/A four-barrel rotary cannon for close air support, while the other variants can be equipped with external gun pods if needed. The aircraft's ability to carry up to 18,000 pounds of ordnance on internal and external hardpoints allows it to perform various missions, from air dominance to ground support.

The F-35’s agility, advanced avionics, and stealth capabilities make it a formidable force in modern aerial combat. Its supermaneuverability, achieved through advanced flight controls and thrust vectoring, allows it to execute sharp turns, rapid climbs, and complex maneuvers, providing a decisive edge in dogfights and evasive maneuvers. With a maximum operational ceiling of 50,000 feet and the ability to refuel in-flight, the F-35 can conduct long-range missions, making it a versatile and powerful asset for modern air forces. The F-35 Lightning II stands at the forefront of fighter technology, offering unparalleled capabilities that redefine air combat for the 21st century.
""", topSpeed: 1227, modelPathName: "F35_Lightning2", sound: .jetPlaneNoise, animationType: .agile_fast_plane)



let Sukhoi = Aircraft(name: "Su-47 Berkut", origin: .russia, yearIntroduced: 2000, status: .experimental, Manufacturer: "Sukhoi", description: """
The Sukhoi Su-47 Berkut, also known as the “Golden Eagle,” is an experimental supersonic jet fighter developed by the Sukhoi Design Bureau in Russia. Renowned for its distinctive forward-swept wing design, the Su-47 was created as a testbed for advanced aerodynamics, materials, and technologies that would influence the development of future Russian fighters. First flown in 1997, the Su-47 was a showcase of cutting-edge aviation technology, combining exceptional agility, advanced avionics, and stealth features, setting the stage for the development of next-generation aircraft like the Su-57.

The Su-47 features a striking forward-swept wing configuration, which significantly enhances its maneuverability, especially at low speeds and high angles of attack. This unique wing design, along with canards and large vertical stabilizers, gives the Su-47 outstanding agility, stability, and control, allowing it to perform complex aerial maneuvers that are difficult for conventional fighters. The aircraft’s structure incorporates advanced composite materials that provide the necessary strength and flexibility to withstand the intense aerodynamic forces experienced during high-speed flight.

The Su-47 was primarily an experimental aircraft and was not equipped with a full combat loadout; however, it was designed with provisions for a range of weaponry, including air-to-air and air-to-ground missiles, guided bombs, and a 30mm GSh-30-1 cannon. The aircraft’s internal weapon bays and stealthy design elements, such as radar-absorbing materials, were aimed at reducing its radar cross-section, enhancing its survivability in hostile environments.

The Su-47’s development was driven by the need to explore new technologies that could enhance the performance and capabilities of future Russian fighters. Its forward-swept wings were intended to improve lift, reduce drag, and enhance maneuverability, especially in air combat scenarios. Although the Berkut did not enter mass production, its innovative design provided valuable data and demonstrated the potential of advanced aerodynamic concepts.

The Su-47 Berkut played a significant role as a technological demonstrator, influencing the design philosophy of the Sukhoi Su-57, Russia’s fifth-generation stealth fighter. The lessons learned from the Berkut’s advanced flight control systems, materials, and aerodynamics helped shape the direction of modern Russian fighter development, contributing to the creation of aircraft that could compete with the latest Western designs.
""", topSpeed: 1400, modelPathName: "Sukhoi", sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

let mig_35 = Aircraft(name: "MiG 35", origin: .russia, yearIntroduced: 2019, status: .active, Manufacturer: "Mikoyan", description: """
The Mikoyan MiG-35 is a Russian multirole fighter developed by Mikoyan, a division of the United Aircraft Corporation (UAC). It is marketed as a 4++ generation jet fighter and is based on the MiG-29M/M2 and MiG-29K/KUB fighters. The MiG-35 has vastly improved avionics and weapon systems compared to earlier variants of the MiG-29, including new precision-guided targeting capability and an optical locator system for independent multirole missions.

The MiG-35 comes in two versions: the single-seat MiG-35S and the two-seat MiG-35UB. It features a PESA radar with an option for AESA radar, although thrust vectoring control, originally planned, is not included in serial production aircraft. The fighter has been designed to have enhanced operational autonomy compared to previous Russian combat aircraft.

The development history of the MiG-35 includes earlier references to a different design in the late 1980s and the unveiling of a model at the 2007 Aero India air show. However, deficiencies in radar and engines led to its exclusion from the Indian MRCA competition. Russia later announced plans to order 37 MiG-35 aircraft, with production and delivery timelines adjusted due to budget constraints.

The new MiG-35, introduced in 2017, incorporates significant upgrades such as a fly-by-wire flight control system, improved cockpit, and integrated precision-guided targeting capability. The Russian Defense Ministry has agreed to purchase 24 MiG-35s as part of its state armament program, with additional contracts planned.

Flight testing of the MiG-35 began in 2016, with production and delivery schedules adjusted over the following years. The aircraft is powered by two FADEC RD-33MK Morskaya Osa turbofans, which provide increased thrust and reduced visibility compared to previous models. The MiG-35 is equipped with a variety of weapons, including laser-guided munitions and the capability to launch long-range cruise missiles.

The cockpit of the MiG-35 features a glass cockpit with night-vision goggles and multiple LCD displays. Serial production aircraft are equipped with a PESA radar, with an AESA radar offered for export markets. Overall, the MiG-35 represents a significant advancement in Russian fighter technology, with improved combat efficiency, versatility, and operational characteristics.
""", topSpeed: 1300, modelPathName: "MiG_35", sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

let Eurofighter_Typhoon = Aircraft(name: "Eurofighter Typhoon", origin: .EuropeanConsortiumUKGermanyItalySpain, yearIntroduced: 2003, status: .active, Manufacturer: "Eurofighter Jagdflugzeug GmbH", description: """
The Eurofighter Typhoon is a European multinational twin-engine, supersonic, canard delta wing, multirole fighter. Designed primarily as an air-superiority fighter, it is manufactured by a consortium of Airbus, BAE Systems, and Leonardo. The project is managed by the NATO Eurofighter and Tornado Management Agency, with the UK, Germany, Italy, and Spain as the primary customers.

Development of the Eurofighter Typhoon began in 1983 with the Future European Fighter Aircraft program, involving collaboration among the UK, Germany, France, Italy, and Spain. The project faced challenges such as disagreements over design authority and operational requirements, leading France to leave the consortium and develop the Dassault Rafale independently.

The Eurofighter prototype made its maiden flight on March 27, 1994. The aircraft's development faced delays due to changing geopolitical factors and disagreements among partner nations. Despite these challenges, the Eurofighter Typhoon entered operational service in 2003 and is currently in use by several air forces, including those of Austria, Italy, Germany, the United Kingdom, Spain, Saudi Arabia, and Oman. Additionally, Kuwait and Qatar have ordered the aircraft.

The Eurofighter Typhoon is known for its agility and combat capabilities, being effective both in air-to-air combat and air-to-surface strike missions. It has been continuously upgraded to enhance its capabilities, including improvements to its radar, weaponry, and electronic warfare systems.

Upgrades to the Eurofighter Typhoon have included integration of new weapons systems, enhancements to aerodynamics, and improvements in electronic warfare capabilities. Projects like Project Centurion in the UK and proposed upgrades for the German Tornado replacement aim to further enhance the aircraft's capabilities, ensuring its relevance for future operational requirements.

Overall, the Eurofighter Typhoon remains a significant asset in the arsenal of European air forces, demonstrating its versatility and effectiveness in a wide range of missions.
""", topSpeed: 1320, modelPathName: "Eurofighter_Typhoon",sound: .jetPlaneNoise, animationType: .agile_fast_plane)

let F_22_Raptor = Aircraft(name: "F-22 Raptor", origin: .america, yearIntroduced: 2005, status: .active, Manufacturer: "Lockheed Martin", description: """
The F-22 Raptor is a fifth-generation, single-seat, twin-engine stealth air superiority fighter developed by Lockheed Martin and Boeing for the United States Air Force. As the world’s first operational stealth fighter, the F-22 combines stealth, speed, agility, and situational awareness with lethal long-range and close-combat capabilities. It was designed to maintain air dominance against any potential adversary, providing the United States with unmatched air superiority in both offensive and defensive roles. First entering service in 2005, the F-22 is often regarded as one of the most advanced and formidable fighters ever built, with capabilities that remain unparalleled.

The F-22 features a sleek, angular design that prioritizes stealth, with internal weapons bays, canted vertical stabilizers, and a carefully shaped airframe to minimize radar cross-section. Its skin is coated with radar-absorbent materials, and its engine exhaust nozzles are designed to reduce heat signatures, making the aircraft nearly invisible to radar and infrared sensors. Powered by two Pratt & Whitney F119-PW-100 engines with thrust vectoring nozzles, the F-22 can achieve supercruise speeds of up to Mach 1.8 without afterburners, allowing it to sustain supersonic flight for extended periods, a crucial advantage in combat scenarios.

Equipped with state-of-the-art avionics, the F-22’s advanced AN/APG-77 AESA radar provides superior target detection and tracking capabilities, allowing the pilot to engage multiple targets simultaneously at long ranges. The aircraft’s Integrated Sensor Suite fuses data from multiple sensors, giving the pilot unparalleled situational awareness. The cockpit is designed with a full glass display, a wide-angle Head-Up Display (HUD), and voice-activated controls, allowing the pilot to focus on mission objectives with reduced workload. Additionally, the F-22’s electronic warfare systems can jam enemy radar and communications, enhancing its survivability and lethality in contested environments.

The F-22 is armed with a combination of air-to-air and air-to-ground weaponry, including the AIM-120 AMRAAM and AIM-9X Sidewinder missiles for aerial combat. It also carries a 20mm M61A2 Vulcan cannon for close-range engagements. For ground attack missions, the Raptor can be equipped with precision-guided bombs like the GBU-32 JDAM, making it a versatile platform capable of striking targets with pinpoint accuracy. All weapons are stored internally to maintain the aircraft’s stealth profile during combat.

The United States government strictly prohibits the export of the F-22 Raptor, even to allied nations. This decision stems from concerns over safeguarding the Raptor’s cutting-edge technologies and maintaining U.S. air superiority. Consequently, Lockheed Martin, the primary manufacturer, is not allowed to sell the F-22 to any foreign country, making it a unique asset exclusively for the U.S. Air Force. This export ban ensures that its advanced stealth, sensor, and combat capabilities remain exclusive to U.S. defense interests.
""", topSpeed: 1500, modelPathName: "F_22_Raptor", sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

/* old f22 descpritons
 //The Lockheed Martin F-22 Raptor is an American fighter aircraft designed for air superiority. It features a single-seat, twin-engine configuration and is equipped with advanced stealth technology. Developed by Lockheed Martin Aeronautics and Boeing Defense, Space & Security, the F-22 Raptor made its first flight on September 7, 1997, and was introduced into service on December 15, 2005.
 //
 //Initially conceived as part of the Advanced Tactical Fighter (ATF) program to replace the F-15 Eagle and F-16 Fighting Falcon, the F-22 Raptor was designed to excel in air-to-air combat while also possessing ground attack, electronic warfare, and signals intelligence capabilities.
 //
 //Manufacturing of the F-22 Raptor took place from 1996 to 2011, during which a total of 195 aircraft were built. The program faced challenges such as budget constraints, leading to a reduction in the number of aircraft produced compared to the original plans. The last F-22 was delivered in 2012.
 //
 //Despite its advanced capabilities, the F-22 Raptor faced criticism and debate over its cost-effectiveness and relevance in modern warfare scenarios. As a result, production was ultimately terminated, and the focus shifted to other aircraft programs such as the F-35 Lightning II.
 //
 //Even so, The remaining F-22 Raptor fleet remains a significant asset in the United States Air Force's arsenal.
 //
 */



let starfighter = Aircraft(name: "F-104 Starfighter", origin: .america, yearIntroduced: 1958, status: .notActive, Manufacturer: "Lockheed", description: """
The Lockheed F-104 Starfighter played a pivotal role during the Cold War, serving as both an air superiority fighter and a fighter-bomber. Initially conceived by Lockheed as a day fighter, it  evolved into an all-weather multirole aircraft in the early 1960s. While its service with the United States Air Force (USAF) was relatively short-lived due to engine issues and a preference for longer-range fighters, the F-104 found considerable success among other NATO and allied nations.

It was developed in response to feedback from Korean War fighter pilots who sought a compact, high-speed aircraft, the F-104 took its inaugural flight in 1954. Its distinctive design featured thin, stubby wings positioned farther back on the fuselage compared to contemporary aircraft, granting exceptional supersonic performance but resulting in poor turning capability and high landing speeds.

The F-104 achieved several significant milestones, becoming the first production aircraft to surpass Mach 2 and reach an altitude of 100,000 feet under its own power. In 1958, it set world records for airspeed, altitude, and time-to-climb. Armed with a 20 mm M61 Vulcan autocannon and capable of carrying AIM-9 Sidewinder air-to-air missiles, bombs, rocket pods, and even a nuclear missile, it proved to be a versatile platform.

Despite its success with NATO and allied nations, the F-104 garnered notoriety for its poor safety record, particularly within the Luftwaffe which also flew them, where it earned the grim nick-name the "Witwenmacher" (meaning "widowmaker") due to the aircraft's high accident rate with Germany and the significant losses of both aircraft and pilots.
""", topSpeed: 1528, modelPathName: "F_104_Starfighter",sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

let mig17 = Aircraft(name: "MiG-17", origin: .ussr, yearIntroduced: 1952, status: .active, Manufacturer: "Mikoyan-Gurevich", description: """
The Mikoyan-Gurevich MiG-17, known by its NATO reporting name "Fresco," is a high-subsonic fighter aircraft originating from the Soviet Union. Developed as an advanced modification of the MiG-15 during the Korean War, the MiG-17 entered service in October 1952 and became one of the most successful fighters of its era. It was designed to intercept slower American bombers but found surprising success in combat against faster American fighters and fighter-bombers during the Vietnam War, where its agility and maneuverability proved advantageous.

The MiG-17 featured several advancements over its predecessor, including a thinner and more highly swept wing and tailplane, allowing for speeds approaching Mach 1. It was equipped with the Klimov VK-1 engine, the first Soviet fighter to feature an afterburner, enhancing its performance. While visually similar to the MiG-15, the MiG-17 incorporated improvements such as additional wing fences, a ventral fin, and a longer rear fuselage.

During its operational history, the MiG-17 saw action in various conflicts, including the Second Taiwan Strait Crisis, where it clashed with Republic of China F-86 Sabres, and the Vietnam War, where it engaged American fighter-bombers such as the F-4 Phantom and F-105 Thunderchief. Despite its subsonic speed, the MiG-17's maneuverability and armament, including cannons, made it a formidable opponent against faster adversaries.

The MiG-17's production spanned various variants, including the MiG-17F with an afterburner, the MiG-17P with radar, and the MiG-17PF with improved radar capabilities. License production occurred in Poland and China, resulting in variants such as the PZL-Mielec Lim-6 and the Shenyang J-5.

In combat, the MiG-17 faced off against advanced American aircraft, scoring aerial victories and earning praise from North Vietnamese pilots for its agility. Although eventually surpassed by supersonic interceptors like the MiG-21, the MiG-17 played a significant role in shaping aerial warfare during the Cold War era and remains a stable of warfare history.
""", topSpeed: 711, modelPathName: "mig_177", emitter: .none, sound: .largePlaneNoise, animationType: .agile_slow_plane, needToPurchase: true)

let UH_60 = Aircraft(name: "UH-60 Black Hawk", origin: .america, yearIntroduced: 1979, status: .active, Manufacturer: "Sikorsky", description: """
The Sikorsky UH-60 Black Hawk is a multi-mission, twin-engine utility helicopter developed by Sikorsky Aircraft for the United States Army. Introduced in 1979 as a replacement for the UH-1 Iroquois (Huey), the Black Hawk quickly became the backbone of U.S. Army aviation and one of the most widely used military helicopters in the world.

The UH-60 Black Hawk features a robust design with a four-blade main rotor and a twin-tail rotor configuration that provides excellent lift, stability, and maneuverability in various operational conditions. It also has the ability to be refueled in-flight to extend its mission duration. Its advanced flight controls and rugged airframe allow it to operate in harsh environments, including high altitudes, extreme temperatures, and confined landing zones, making it highly adaptable to different combat and support roles.

The Black Hawk’s spacious cabin can accommodate up to 11 fully equipped troops or four stretchers in a medevac configuration, along with a crew of two pilots and up to two crew chiefs or door gunners. The helicopter is equipped with advanced avionics, including GPS navigation, night vision-compatible cockpits, and a range of communication systems that enable effective coordination during missions. The UH-60’s cockpit layout is designed to enhance situational awareness, reduce pilot workload, and support all-weather, day-and-night operations.

Armed variants of the Black Hawk, such as the UH-60L and UH-60M, can be equipped with door-mounted machine guns, including the M240, M134 Minigun, or GAU-19, providing defensive firepower during troop insertions, extractions, and medical evacuations. Additionally, some versions can carry external fuel tanks, missile warning systems, and countermeasures to protect against threats from ground fire and surface-to-air missiles, enhancing the helicopter’s survivability in combat zones.

The Black Hawk has seen action in virtually every major U.S. military operation since its introduction, including the invasions of Grenada and Panama, the Gulf War, operations in Somalia, the Balkans, Afghanistan, Iraq, and numerous humanitarian missions. One of the most notable engagements involving the Black Hawk was during the Battle of Mogadishu in 1993, which was later depicted in the book and film “Black Hawk Down.”

The UH-60 Black Hawk’s legacy is defined by its adaptability, reliability, and the crucial role it continues to play in military operations around the world. 
""", topSpeed: 224, modelPathName: "BlackHawk", emitter: .none, sound: .helicopterNoise, animationType: .helicoper)

let Hind = Aircraft(name: "Mi-24", origin: .ussr, yearIntroduced: 1972, status: .active, Manufacturer: "Mil", description: """
The Mil Mi-24, known by its NATO reporting name “Hind,” is a heavily armed attack and transport helicopter developed by the Soviet Union’s Mil Moscow Helicopter Plant. Introduced in 1972, the Mi-24 was the first helicopter to combine the roles of an assault gunship and a troop transport, making it one of the most unique and versatile helicopters in military history. Capable of carrying troops, providing close air support, and engaging armored targets, the Mi-24 has served in numerous conflicts worldwide and remains a symbol of Soviet and Russian military power.

The Mi-24 features a distinctive design with a tandem cockpit for the pilot and gunner, a sleek fuselage, and short, stubby wings that provide lift and carry an array of weapons. Powered by two powerful turboshaft engines, such as the Isotov TV3-117, the Mi-24 can reach speeds of up to 208 mph (335 km/h), making it one of the fastest attack helicopters ever built. It has an operational range of approximately 280 miles (450 km) and can operate in harsh conditions, including high altitudes, hot climates, and rugged terrain, demonstrating exceptional performance in diverse environments.

The Mi-24 is armed with a formidable array of weaponry, including a nose-mounted 12.7mm Yak-B Gatling gun or 30mm cannon, rocket pods, anti-tank guided missiles (such as the AT-6 Spiral), and various bombs. This firepower enables the Hind to engage and destroy a wide range of targets, from enemy infantry and fortifications to tanks and armored vehicles. The helicopter’s ability to unleash a devastating barrage of firepower makes it highly effective in the close air support role, supporting ground troops and disrupting enemy formations.

The Hind’s advanced avionics and armor provide enhanced survivability in combat. Its armored cockpit and engine compartments are designed to withstand small arms fire and shrapnel, while its redundant systems and rugged construction enable it to continue operating even after sustaining damage. The Mi-24’s advanced sighting and targeting systems allow for precise weapon delivery, and newer variants incorporate improved avionics, night vision, and electronic countermeasures, increasing its effectiveness in modern combat scenarios.

It has seen extensive combat service, most notably during the Soviet-Afghan War, where it earned a fearsome reputation among insurgents for its devastating firepower and ability to support ground operations in challenging mountainous terrain. The helicopter has been used in numerous other conflicts, including the Iran-Iraq War, various African conflicts, the Chechen Wars, and more recently, in Syria and Ukraine. Its robust design, adaptability, and combat effectiveness have made it a valuable asset for many air forces worldwide, and it remains in service with numerous countries.

The Mi-24’s impact on modern warfare lies in its versatility and ability to perform multiple roles on the battlefield. Its design influenced the development of other attack helicopters, such as the American AH-64 Apache, which incorporated elements of the Hind’s combat capabilities. The Mi-24’s success demonstrated the value of integrating troop transport capabilities with heavy armament, creating a highly adaptable platform that could fulfill various mission requirements.
""", topSpeed: 208, modelPathName: "Mi_24", emitter: .none, sound: .helicopterNoise, animationType: .helicoper, needToPurchase: true)




let b1Lancer = Aircraft(name: "B-1 Lancer", origin: .america, yearIntroduced: 1986, status: .active, Manufacturer: "Rockwell", description: """
The Rockwell B-1 Lancer, commonly known as the “Bone” (from “B-One”), is a supersonic, variable-sweep wing heavy bomber developed by Rockwell International (now part of Boeing) for the United States Air Force. Introduced in 1986 as part of the strategic bomber fleet, the B-1 was originally designed as a nuclear-capable bomber to penetrate Soviet air defenses during the Cold War. However, it has since been adapted primarily for conventional bombing roles, providing the U.S. military with a versatile, high-speed platform capable of carrying a vast array of precision-guided and unguided munitions. The B-1 Lancer’s speed, range, and payload capacity make it one of the most powerful and adaptable bombers in the world.

The B-1 features a distinctive variable-sweep wing design, allowing it to adjust wing positions for optimal performance at various speeds and flight conditions. The wings can be swept back for supersonic flight or extended forward for greater lift and maneuverability during low-speed operations. Powered by four General Electric F101-GE-102 afterburning turbofan engines, the B-1 can reach speeds of Mach 1.25 and fly at altitudes of up to 60,000 feet (18,300 meters). Its speed, combined with its advanced electronic countermeasures, enables the B-1 to evade enemy defenses and deliver payloads in high-threat environments.

One of the B-1’s most significant advantages is its immense payload capacity, which is the largest of any U.S. bomber. It can carry up to 75,000 pounds (34,000 kg) of mixed ordnance, including JDAMs (Joint Direct Attack Munitions), JASSM (Joint Air-to-Surface Standoff Missiles), cluster bombs, and gravity bombs. This diverse payload allows the B-1 to conduct a wide range of missions, from precision strikes against hardened targets to large-scale bombardment of enemy positions. The bomber’s internal rotary launchers and external hardpoints provide flexibility in weapon configurations, making it highly adaptable for various combat scenarios.

Historically, the B-1 was developed as part of the U.S. strategic nuclear triad, intended to deliver nuclear weapons deep into Soviet territory. However, after the end of the Cold War, the B-1 was reconfigured for conventional warfare, significantly expanding its role in modern conflicts. The B-1 has been used extensively in combat operations, including in Iraq, Afghanistan, Syria, and Kosovo, where it provided critical air support, precision strikes, and interdiction against enemy forces. Its ability to loiter over battlefields, deliver precise munitions, and rapidly reconfigure for different mission profiles has made it an invaluable asset in modern warfare.

The B-1’s ongoing upgrades, including improvements to its avionics, weapons systems, and electronic warfare capabilities, ensure that it remains relevant in the evolving landscape of aerial combat. Despite being initially designed for nuclear missions, the B-1’s adaptability has allowed it to continue serving as a highly capable conventional bomber, providing the U.S. Air Force with a powerful tool for precision strike and air dominance.
""", topSpeed: 960, modelPathName: "b1_lancer", emitter: .none, sound: .largePlaneNoise, animationType: .large_fast_plane, needToPurchase: true)

let phantomF4 = Aircraft(name: "F-4 Phantom II", origin: .america, yearIntroduced: 1961, status: .notActive, Manufacturer: "McDonnell", description: """
The McDonnell Douglas F-4 Phantom II is an American tandem two-seat, twin-engine, all-weather, long-range supersonic jet interceptor and fighter-bomber originally developed by McDonnell Aircraft for the United States Navy. Proving highly adaptable, it entered service with the Navy in 1961 before it was adopted by the United States Air Force and the United States Marine Corps, and by the mid-1960s it had become a major part of their air arms. Phantom production ran from 1958 to 1981 with a total of 5,195 aircraft built, making it the most produced American supersonic military aircraft in history, and cementing its position as a signature combat aircraft of the Cold War.

 The Phantom is a large fighter with a top speed of over Mach 2.2. It can carry more than 18,000 pounds (8,400 kg) of weapons on nine external hardpoints, including air-to-air missiles, air-to-ground missiles, and various bombs. The F-4, like other interceptors of its time, was initially designed without an internal cannon. Later models incorporated an M61 Vulcan rotary cannon. Beginning in 1959, it set 15 world records for in-flight performance, including an absolute speed record and an absolute altitude record.

 The F-4 was used extensively during the Vietnam War. It served as the principal air superiority fighter for the U.S. Air Force, Navy, and Marine Corps and became important in the ground-attack and aerial reconnaissance roles late in the war. During the Vietnam War, one U.S. Air Force pilot, two weapon systems officers (WSOs), one U.S. Navy pilot and one radar intercept officer (RIO) became aces by achieving five aerial kills against enemy fighter aircraft. The F-4 continued to form a major part of U.S. military air power throughout the 1970s and 1980s, being gradually replaced by more modern aircraft such as the F-15 Eagle and F-16 Fighting Falcon in the U.S. Air Force, the F-14 Tomcat in the U.S. Navy, and the F/A-18 Hornet in the U.S. Navy and U.S. Marine Corps.

 The F-4 Phantom II remained in use by the U.S. in the reconnaissance and Wild Weasel (Suppression of Enemy Air Defenses) roles in the 1991 Gulf War, finally leaving service in 1996. It was also the only aircraft used by both U.S. flight demonstration teams: the United States Air Force Thunderbirds (F-4E) and the United States Navy Blue Angels (F-4J). The F-4 was also operated by the armed forces of 11 other nations. Israeli Phantoms saw extensive combat in several Arab–Israeli conflicts, while Iran used its large fleet of Phantoms, acquired before the fall of the Shah, in the Iran–Iraq War. As of 2023, 63 years after its first flight, the F-4 remains in active service with the air forces of Iran, South Korea, Greece, and Turkey. The aircraft has most recently been in service against the Islamic State group in the Middle East.
""" ,topSpeed: 1690, modelPathName: "phantomF4", sound: .jetPlaneNoise, animationType: .agile_fast_plane)

let tomcat = Aircraft(name: "F-14 Tomcat", origin: .america, yearIntroduced: 1974, status: .notActive, Manufacturer: "Grumman", description: """
The Grumman F-14 Tomcat is a twin-engine, variable-sweep wing fighter aircraft developed for the United States Navy as a long-range naval interceptor, air superiority fighter, and fleet defense aircraft. First introduced in 1974, the F-14 was designed to counter advanced Soviet threats during the Cold War, including high-speed bombers and anti-ship missiles, while also providing the Navy with superior dogfighting capabilities. The Tomcat became one of the most iconic and formidable fighters of its time, known for its speed, maneuverability, and distinctive swing-wing design that allowed it to excel in a variety of combat scenarios.

The F-14 features a unique variable-geometry wing design, allowing the wings to sweep forward or backward depending on the flight conditions. This design provided the aircraft with high agility and maneuverability at low speeds while enabling high-speed performance at supersonic velocities. Powered by two Pratt & Whitney TF30 engines (later replaced with more reliable General Electric F110 engines in upgraded models), the F-14 could achieve speeds of over Mach 2.3 and operate at altitudes up to 50,000 feet (15,240 meters). Its robust airframe and powerful engines made it well-suited for fleet defense and extended patrol missions over the open ocean.

One of the F-14’s standout features was its advanced radar and targeting systems, particularly the AN/AWG-9 radar and later the AN/APG-71, which provided long-range detection and tracking capabilities. The radar was integrated with the AIM-54 Phoenix missile system, allowing the F-14 to engage multiple targets simultaneously at ranges of over 100 miles. This combination made the Tomcat the first fighter capable of engaging multiple high-speed targets beyond visual range, giving the Navy a significant advantage in defending carrier strike groups against incoming threats.

The F-14 Tomcat gained widespread recognition for its combat performance and its role in popular culture, particularly after being featured in the 1986 film “Top Gun.” The aircraft saw extensive service in numerous conflicts, including the Gulf War, the Iraq War, and operations over Bosnia and Afghanistan, where it provided air cover, reconnaissance, and precision strike capabilities.

Historically, the F-14 Tomcat was a critical asset for the U.S. Navy during the latter half of the Cold War and beyond, representing a significant technological leap in naval aviation. Its ability to protect carrier strike groups and dominate airspace played a crucial role in maintaining U.S. naval superiority. Although retired by the U.S. Navy in 2006, the F-14’s legacy endures as one of the most iconic and capable fighters of its era, and it continues to be remembered for its unique design, combat effectiveness, and role in shaping naval aviation history.
""", topSpeed: 1800, modelPathName: "f14Tomcat", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: false)

let warthog = Aircraft(name: "A-10 Thunderbolt II", origin: .america, yearIntroduced: 1977, status: .active, Manufacturer: "Fairchild Republic", description: """
The Fairchild Republic A-10 Thunderbolt II, commonly known as the “Warthog,” is a rugged, twin-engine, close air support (CAS) aircraft developed for the United States Air Force. Specifically designed to destroy enemy armored vehicles, tanks, and ground forces, the A-10 has become renowned for its toughness, lethality, and ability to provide critical support to ground troops in combat. Introduced in 1977, the A-10 was developed during the Cold War to counter Soviet armored advances in Europe, but it has since proven invaluable in numerous conflicts, from the Gulf War to operations in Iraq, Afghanistan, and Syria.

The A-10 features a distinctive design optimized for low-speed, low-altitude performance, with a straight-wing configuration that provides exceptional maneuverability and stability during strafing runs and in tight spaces. 

One of the most defining features of the A-10 is its 30mm GAU-8/A Avenger rotary cannon, which is mounted on the nose of the aircraft. This seven-barrel autocannon is capable of firing up to 3,900 rounds per minute (70 rounds a second) of depleted uranium armor-piercing and high-explosive incendiary rounds, allowing the A-10 to devastate tanks, armored vehicles, and fortifications. The cannon is positioned slightly off-center to balance the recoil force, and the aircraft is effectively built around this weapon, making it one of the most fearsome tank-busters ever created.

In addition to its cannon, the A-10 can carry a wide array of munitions on its 11 hardpoints, including AGM-65 Maverick missiles, Hydra 70 rockets, guided bombs, and laser-guided munitions, allowing it to adapt to various mission needs. Its extensive payload options, combined with its ability to loiter over battlefields for extended periods, make it an ideal platform for supporting ground troops in dynamic and hostile environments.

The A-10’s survivability is one of its most celebrated attributes. The aircraft is heavily armored with titanium “bathtub” armor surrounding the pilot, protecting against ground fire and small arms. Its redundant flight controls, self-sealing fuel tanks, and manual reversion systems enable the A-10 to continue flying even after sustaining significant battle damage. The aircraft’s low-speed, high-maneuverability characteristics allow it to operate from short, austere airstrips close to the front lines, making it an agile and resilient presence on the battlefield.

The A-10’s historic significance lies in its unwavering dedication to the close air support mission. Unlike faster, more sophisticated jets, the A-10 was specifically built to fly low and slow, directly engaging ground targets and providing direct support to those in the fight. Despite ongoing debates about its future and attempts to replace it, the A-10’s unique capabilities have ensured its continued service, endearing it to both pilots and the troops it supports. The Warthog remains a symbol of American airpower, celebrated for its toughness, firepower, and steadfast commitment to the CAS role, embodying the essential qualities of a true battlefield workhorse.
""", topSpeed: 518, modelPathName: "Warthog", emitter: .none, sound: .jetPlaneNoise, animationType: .large_fast_plane, needToPurchase: true)

let me_109 = Aircraft(name: "BF 109", origin: .naziGermany, yearIntroduced: 1937, status: .notActive, Manufacturer: "Bayerische Flugzeugwerke", description: """
The Messerschmitt Bf 109, often referred to simply as the Me 109, is one of the most iconic and widely used fighter aircraft of World War II. Designed by Willy Messerschmitt and Robert Lusser, the Bf 109 served as the backbone of the German Luftwaffe’s fighter force throughout the war. Introduced in 1937, it was a revolutionary design for its time, featuring advanced aerodynamics, a powerful engine, and exceptional armament that made it one of the most formidable fighters of the conflict. The Bf 109 was involved in nearly every major theater of the war, from the Battle of Britain to the Eastern Front, North Africa, and the Mediterranean, making it one of the most produced and versatile aircraft in history.

Equipped with a range of armaments that evolved over time, the Bf 109 typically carried a combination of machine guns and cannons mounted in the nose and wings, allowing for concentrated firepower that was devastating in aerial combat. Early versions were armed with two 7.92 mm MG 17 machine guns and later variants incorporated heavier 20mm MG 151 cannons, enhancing its firepower against both aircraft and ground targets. Some versions were also fitted with underwing cannons or rockets for additional strike capability.

The cockpit of the Bf 109 was cramped but provided good visibility for the pilot, especially in later variants with redesigned canopies. The aircraft’s robust airframe and advanced flight controls allowed for precise handling, although its narrow landing gear made takeoffs and landings challenging, especially on rough fields. Despite these handling difficulties, the Bf 109 was praised by its pilots for its agility and combat effectiveness.

The Bf 109’s versatility was demonstrated by its adaptation to numerous roles beyond its original fighter design. It served as a fighter-bomber, reconnaissance aircraft, and even as a night fighter in later stages of the war. This adaptability, combined with its performance, made it a critical tool for the Luftwaffe in various combat scenarios. It was flown by many of Germany’s top aces, including Erich Hartmann, the highest-scoring fighter pilot in history, who achieved 352 aerial victories, most of them in a Bf 109.

The Bf 109 played a pivotal role in the early Luftwaffe successes, particularly during the Battle of Britain, where it served as the primary fighter escort for German bombers. Its involvement in the air battles over Europe was crucial, though it eventually faced increasingly sophisticated Allied fighters like the Supermarine Spitfire and the North American P-51 Mustang, which matched or exceeded its capabilities.

The Bf 109’s legacy endures as a symbol of wartime aviation and as a key aircraft that shaped the course of aerial combat during World War II. Its combination of advanced design, versatility, and combat performance makes it one of the most legendary fighters of all time, remembered both for its technological innovations and its role in the conflict that defined a generation.
""", topSpeed: 400, modelPathName: "me_109", emitter: .none, sound: .propellerPlaneNoise, animationType: .agile_slow_plane, needToPurchase: false)

let stealthBomber = Aircraft(name: "B-2 Stealth Bomber", origin: .america, yearIntroduced: 1997, status: .active, Manufacturer: "Northrop", description: """
The Northrop Grumman B-2 Spirit, known as the B-2 Stealth Bomber, is a revolutionary long-range, heavy bomber developed during the Cold War to penetrate advanced Soviet air defenses and deliver nuclear and conventional payloads. Developed under the Advanced Technology Bomber (ATB) program, the B-2 was designed by Northrop Grumman with a distinctive flying wing design that minimizes radar cross-section, making it nearly invisible to radar. Introduced in 1997, the B-2 remains a key component of the U.S. Air Force’s strategic bomber fleet.

The aircraft features a distinctive flying wing design, lacking a traditional tail or fuselage, which significantly reduces its radar signature. The B-2's sleek, dark gray body is made from radar-absorbent materials that further enhance its stealth. Its smooth, flowing contours minimize radar reflections, allowing it to penetrate deep into enemy territory undetected. 

The B-2 is powered by four General Electric F118-GE-100 turbofan engines, which are mounted within the wing to further reduce the bomber's radar and infrared signature. It has a wingspan of 172 feet (52.4 meters) and is capable of carrying both conventional and nuclear weapons. The bomber can deploy a variety of munitions, including GPS-guided bombs, gravity bombs, and nuclear weapons, making it a versatile asset in strategic bombing missions.

The cockpit of the B-2 is equipped with advanced avionics and a state-of-the-art fly-by-wire control system, allowing for precise maneuvering and navigation during missions. Despite its large size, the aircraft is operated by just two crew members: a pilot and a mission commander.

The B-2's ability to fly long distances without refueling—up to 6,000 nautical miles unrefueled and more than 10,000 nautical miles with aerial refueling—makes it a formidable asset for global strike operations. Its stealth technology, combined with advanced defensive systems, ensures that the B-2 can reach heavily defended targets while remaining nearly invisible to enemy radar, making it one of the most iconic and technologically advanced aircraft in the world.
""" , topSpeed: 630, modelPathName: "stealthBomber", emitter: .none, sound: .largePlaneNoise, animationType: .large_slow_plane)

let blackBird = Aircraft(name: "SR-71 Blackbird", origin: .america, yearIntroduced: 1966, status: .notActive, Manufacturer: "Lockheed", description: """
The Lockheed SR-71 Blackbird is an American long-range, high-altitude, Mach 3+ strategic reconnaissance aircraft developed by Lockheed's Skunk Works division. Designed primarily for intelligence gathering, the SR-71 was renowned for its unparalleled speed and altitude, making it one of the most advanced aircraft of its time. First introduced in 1966, the SR-71 was operated by the United States Air Force until its retirement in 1998, serving as a critical tool for reconnaissance missions during the Cold War.

The SR-71 features a sleek, needle-like fuselage and sharply swept-back wings, optimized for high-speed, high-altitude flight. Its airframe is primarily constructed from titanium alloys to withstand the extreme temperatures generated during sustained Mach 3+ flight, which could exceed 800°F (427°C) on the aircraft’s surface. The Blackbird’s stealth characteristics, though limited compared to modern standards, included a unique radar-absorbing paint and its overall shape, which helped reduce its radar signature.

Powered by two Pratt & Whitney J58 turbojet engines, each capable of producing 34,000 pounds of thrust, the SR-71 could reach speeds of over Mach 3.3 and operate at altitudes above 85,000 feet (25,900 meters). These speeds and altitudes allowed it to outrun surface-to-air missiles and enemy interceptors, making it nearly invulnerable to conventional defenses. The engines featured an innovative design that included variable inlets and afterburners, optimized for supersonic efficiency and capable of converting to ramjet-like operation at high speeds.

The aircraft was equipped with sophisticated cameras, sensors, and electronic intelligence-gathering equipment capable of capturing detailed imagery and data from vast distances. The SR-71’s advanced navigation systems allowed precise mission execution, even at extreme speeds and altitudes. Its dual-cockpit layout accommodated a pilot and a reconnaissance systems officer, who managed the complex array of surveillance equipment during missions.

Throughout its service life, the SR-71 conducted reconnaissance missions over hostile territory, providing critical intelligence data during conflicts such as the Vietnam War, Cold War, and other global hotspots. Its ability to fly faster and higher than any other operational aircraft made it an invaluable asset for gathering strategic intelligence, often flying into areas that were too dangerous for other reconnaissance aircraft.

Despite its extraordinary capabilities, the SR-71 was also known for its high operational costs and maintenance demands, partly due to its complex engines and titanium structure. The aircraft required specialized fuels and maintenance techniques, adding to its expense. However, the SR-71 remains one of the most iconic and innovative aircraft in aviation history, celebrated for its unmatched speed, altitude, and role in providing critical intelligence during some of the most tense periods of the 20th century.

The SR-71 was retired from service in 1998. It was replaced by the RQ-4 Global Hawk, which is a high-altitude unmanned aerial vehicle
""", topSpeed: 2608, modelPathName: "blackbird", emitter: .none, sound: .largePlaneNoise,  animationType: .large_fast_plane, needToPurchase: true)

let f_15 = Aircraft(name: "F-15 Eagle", origin: .america, yearIntroduced: 1976, status: .active, Manufacturer: "McDonnell Douglas", description: """
The McDonnell Douglas F-15 Eagle is an American twin-engine, all-weather tactical fighter aircraft designed to gain and maintain air superiority in aerial combat. Developed by McDonnell Douglas (now part of Boeing) in the 1970s, the F-15 has become one of the most successful modern fighter aircraft, with a combat record of over 100 victories and no losses in aerial combat. Entering service in 1976, the F-15 continues to be a critical asset for the United States Air Force and other air forces worldwide, thanks to its exceptional speed, maneuverability, and combat capability.

The F-15 features a high-mounted swept wing, twin vertical stabilizers, and a large bubble canopy, providing excellent visibility for the pilot. Its robust airframe is built primarily from aluminum alloys and titanium, designed to withstand high-stress maneuvers during combat. The aircraft’s twin Pratt & Whitney F100 engines, each producing up to 23,500 pounds of thrust with afterburners, enable the F-15 to reach speeds of over Mach 2.5 and climb to altitudes above 65,000 feet (20,000 meters). The Eagle’s high thrust-to-weight ratio and advanced aerodynamics provide superior agility and acceleration, allowing it to engage and outmaneuver enemy aircraft effectively.

The F-15’s armament consists of a versatile array of air-to-air and air-to-ground weapons. It carries a standard loadout of AIM-7 Sparrow, AIM-120 AMRAAM, and AIM-9 Sidewinder missiles for air superiority missions. Additionally, the aircraft is equipped with a 20mm M61 Vulcan rotary cannon, capable of delivering a high rate of fire in close combat situations. For ground attack roles, the F-15 can also carry a variety of bombs, including laser-guided and GPS-guided munitions, allowing it to strike surface targets with precision.

Throughout its service, the F-15 has seen action in numerous conflicts, including the Gulf War, where it achieved a dominant kill-to-loss ratio, as well as operations in Iraq, Afghanistan, and other global theaters. Its success is attributed to its combination of speed, maneuverability, advanced avionics, and robust firepower, which make it a formidable fighter in any aerial engagement.

The F-15 Eagle’s design has evolved over the decades, leading to multiple variants, including the F-15C/D air superiority models, the F-15E Strike Eagle for multi-role missions, and the latest F-15EX, which incorporates advanced avionics, electronic warfare capabilities, and improved weapon systems. Despite its age, ongoing upgrades have kept the F-15 relevant, and it is expected to remain in service for many years, continuing its legacy as one of the most respected and capable fighters in the world.
""", topSpeed: 1920, modelPathName: "f_15",sound: .jetPlaneNoise, animationType: .agile_fast_plane)

let chengdu = Aircraft(name: "J-20", origin: .china, yearIntroduced: 2017, status: .active, Manufacturer: "Chengdu", description: """
The Chengdu J-20, also known as the "Mighty Dragon," is a fifth-generation, twin-engine stealth fighter developed by the Chengdu Aerospace Corporation for the People’s Liberation Army Air Force (PLAAF). As China’s most advanced fighter jet, the J-20 is designed to achieve air superiority, conduct ground attack missions, and perform electronic warfare, placing it in direct competition with other modern fighters like the F-22 Raptor and F-35 Lightning II. The J-20 made its first flight in 2011 and was officially introduced into service in 2017, representing a significant leap in China’s military aviation capabilities.

The J-20 features a sleek, angular design optimized for stealth, with canards positioned near the cockpit, canted vertical stabilizers, and a sharp, delta wing configuration that reduces its radar cross-section. The aircraft’s body is constructed using advanced composite materials and radar-absorbent coatings, enhancing its stealth characteristics. Its forward fuselage includes a chin-mounted air intake system, designed to feed the engines efficiently while minimizing radar exposure.

Powered initially by Russian AL-31 engines, later versions of the J-20 are being equipped with more advanced Chinese-made WS-10C or WS-15 engines, which provide improved thrust, reliability, and supercruise capabilities. The J-20 can reach speeds of over Mach 2 and has a range of approximately 1,200 miles (2,000 km) without refueling, allowing it to operate effectively across vast distances and project power in contested regions.

The J-20’s avionics include an advanced AESA (Active Electronically Scanned Array) radar that provides long-range target detection, tracking, and engagement capabilities. It also features a Distributed Aperture System (DAS) that offers the pilot 360-degree situational awareness, similar to systems found on other fifth-generation fighters. The cockpit is equipped with large digital displays and a helmet-mounted display system (HMDS), which provides real-time flight data and targeting information, enhancing pilot effectiveness in complex combat environments.

The J-20 is armed with a variety of modern weapons stored internally to maintain its stealth profile. It can carry long-range air-to-air missiles like the PL-15, which features an active radar seeker, and short-range missiles such as the PL-10 for dogfighting scenarios. The aircraft also has provisions for air-to-ground munitions, enabling it to perform precision strikes against surface targets. The internal weapons bay configuration minimizes drag and maintains the aircraft’s low observability.

With its advanced stealth, high speed, and cutting-edge avionics, the J-20 represents a significant advancement in China’s air combat capabilities. The aircraft is designed to engage and defeat high-value targets, including enemy fighters, AWACS, and aerial refueling aircraft, enhancing China’s ability to assert control over contested airspace. The J-20’s development underscores China’s growing aerospace ambitions and marks a critical step in the country’s efforts to modernize its military forces with advanced, indigenous technology. 
""", topSpeed: 1500, modelPathName: "Chengdu",sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

let ac130 = Aircraft(name: "AC-130", origin: .america, yearIntroduced: 1968, status: .active, Manufacturer: "Lockheed", description: """
The Lockheed AC-130 is a heavily armed, long-endurance ground-attack aircraft developed for the United States Air Force and based on the C-130 Hercules transport aircraft. The AC-130 is specifically designed for close air support (CAS), air interdiction, and force protection missions, making it one of the most formidable gunships in the world. Known for its devastating firepower, loitering capability, and precision targeting, the AC-130 has been a critical asset in U.S. military operations since its introduction in the late 1960s, providing direct fire support to ground troops during combat.

The AC-130 features a distinctive side-firing configuration, allowing it to circle targets and engage with pinpoint accuracy. Its armament varies across different variants but typically includes a mix of cannons, autocannons, and howitzers, such as the 40mm Bofors cannon, 30mm GAU-23/A autocannon, and the powerful 105mm M102 howitzer. This array of weaponry allows the AC-130 to deliver a devastating volume of fire against enemy forces, including infantry, armored vehicles, and fortified positions. The aircraft's ability to loiter for extended periods over the battlefield enables it to provide continuous support and respond rapidly to dynamic combat situations.

Equipped with advanced targeting and sensor systems, the AC-130 can conduct operations in all weather conditions, day or night. Its avionics suite includes electro-optical and infrared sensors, radar, and precision-guided munitions targeting systems that allow it to identify, track, and engage multiple targets with exceptional accuracy. The aircraft's fire control system integrates data from these sensors, enabling precise delivery of its weapons even in challenging environments. Newer variants, such as the AC-130J Ghostrider, incorporate upgraded technology, including precision-guided bombs and missiles, enhancing the gunship's versatility and firepower.

The AC-130’s significance extends beyond its firepower; it represents a unique approach to air support that combines advanced technology with the ability to respond directly to the needs of ground commanders. Its loitering capability allows it to remain on station longer than fast jets, offering a sustained and flexible response to evolving threats on the ground. Over the years, the AC-130 has undergone numerous upgrades to enhance its survivability, including infrared countermeasures, advanced radar warning systems, and improved defensive capabilities, ensuring it can continue to operate effectively in contested environments.

The AC-130’s enduring legacy lies in its unmatched ability to deliver powerful, precise support to ground forces. It remains one of the most iconic and effective platforms for CAS, embodying the U.S. military’s commitment to supporting troops on the front lines. Its combination of firepower, persistence, and precision has made the AC-130 a cornerstone of U.S. airpower, continually evolving to meet the demands of modern warfare while maintaining its reputation as the ultimate airborne gunship.
""", topSpeed: 416, modelPathName: "ac130", emitter: .none, sound: .largePropellerPlaneNoise, animationType: .large_slow_plane)

let apache = Aircraft(name: "AH-64 Apache", origin: .america, yearIntroduced: 1986, status: .active, Manufacturer: "Boeing", description: """
The Boeing AH-64 Apache is an American twin-turboshaft attack helicopter developed by Hughes Helicopters, later acquired by McDonnell Douglas and now produced by Boeing Defense. Designed for close air support, anti-tank, and armed reconnaissance missions, the AH-64 is one of the most advanced and heavily armed attack helicopters in the world. First introduced into service in 1986, the Apache has become the backbone of the U.S. Army’s attack helicopter fleet and has been exported to numerous allied nations.

The AH-64 features a tandem cockpit layout with the pilot seated in the rear and the gunner in the front, providing optimal visibility and control during combat operations. Its four-blade main rotor and tail rotor are made from composite materials designed to withstand battle damage, while its robust airframe incorporates armor plating to protect the crew and vital components from small arms fire. The helicopter is powered by two General Electric T700 turboshaft engines, providing a maximum speed of 182 mph (293 km/h) and the ability to operate in a wide range of environmental conditions, from deserts to mountainous terrain.

The Apache is equipped with advanced avionics and sensors that make it a formidable force on the battlefield. Its primary sensor suite includes the Target Acquisition and Designation Sight (TADS) and the Pilot Night Vision Sensor (PNVS), which allow for precise target engagement in day, night, and adverse weather conditions. The AH-64E variant features an upgraded suite with the AN/APG-78 Longbow radar, providing 360-degree targeting and tracking capabilities, even through smoke, fog, and dust. The Apache also includes modernized communications systems, data links, and a glass cockpit with multi-functional displays, enhancing situational awareness and mission effectiveness.

The AH-64’s weaponry is diverse and highly effective against a variety of targets. It is armed with a 30mm M230 Chain Gun mounted under the fuselage, which can engage both soft and armored targets with high accuracy. The helicopter’s stub wings are equipped with hardpoints that can carry a mix of AGM-114 Hellfire missiles for anti-tank roles, Hydra 70 rockets for area suppression, and AIM-92 Stinger missiles for air-to-air engagements. This versatile loadout allows the Apache to engage enemy armor, infantry, and even other helicopters, making it a key asset in modern combat.

The Apache’s survivability is enhanced by its advanced electronic warfare suite, which includes missile warning systems, radar jammers, and infrared countermeasures designed to protect against surface-to-air missiles and other threats. Its redundancy and damage-tolerant design ensure that the aircraft can continue to operate even after sustaining hits, giving it an edge in high-threat environments.

The AH-64 Apache has seen extensive combat action in numerous conflicts, including the Gulf War, the wars in Iraq and Afghanistan, and various other operations worldwide. Its combination of firepower, armor, and advanced technology makes it a highly effective tool for ground support and a critical component of modern military forces. Constant upgrades and enhancements have kept the Apache relevant, with the latest AH-64E Guardian variant incorporating improved engines, advanced sensors, and enhanced network capabilities to maintain its status as one of the world’s premier attack helicopters.
""", topSpeed: 180, modelPathName: "animationTest", emitter: .none, sound: .helicopterNoise, animationType: .helicoper)


let mustang = Aircraft(name: "P-51 Mustang", origin: .america, yearIntroduced: 1942, status: .notActive, Manufacturer: "North America Aviation", description: """
The North American P-51 Mustang is one of the most iconic and celebrated fighter aircraft of World War II, renowned for its exceptional performance, range, and versatility. Developed by North American Aviation, the P-51 was originally designed in response to a British request for a new fighter in 1940, and it quickly evolved into one of the war’s most effective and influential fighters. Known for its speed, maneuverability, and long-range capabilities, the P-51 played a crucial role in securing Allied air superiority, especially in the European Theater, where it escorted bombers deep into enemy territory and engaged in fierce dogfights with the Luftwaffe.

The P-51 Mustang featured a sleek, low-wing monoplane design with a streamlined fuselage, laminar-flow wings, and a powerful engine, all contributing to its outstanding aerodynamics and performance. Initially powered by an Allison V-1710 engine, the aircraft’s true potential was realized with the introduction of the Rolls-Royce Merlin engine, which significantly boosted its performance at high altitudes. This combination of speed, altitude, and maneuverability made the Mustang one of the most formidable fighters of the war.

Equipped with a bubble canopy in the P-51D variant, the Mustang provided the pilot with excellent all-around visibility, a crucial advantage in combat. The aircraft’s armament typically included six .50 caliber Browning M2 machine guns, allowing it to deliver a powerful punch against enemy aircraft and ground targets. It could also carry bombs and rockets, making it effective in ground-attack roles in addition to its primary mission as a fighter.

The P-51’s combat effectiveness was proven in numerous battles, where it excelled in both air-to-air combat and ground-attack missions. It was particularly effective in disrupting enemy logistics, strafing trains, convoys, and airfields, and playing a key role in cutting off supplies to the front lines. The Mustang’s versatility allowed it to adapt to a wide range of combat scenarios, making it invaluable to Allied forces across multiple theaters of war.

The P-51 Mustang was flown by many of the top American and Allied aces of World War II, including George Preddy, Chuck Yeager, and Bud Anderson, who achieved numerous aerial victories in Mustangs. The aircraft’s exceptional performance made it a favorite among pilots, who praised its agility, speed, and forgiving handling characteristics. The Mustang’s ability to outperform and outmaneuver most of its adversaries, including the feared German Bf 109 and Fw 190, cemented its reputation as one of the best fighters of the war.
""", topSpeed: 450, modelPathName: "Mustang", emitter: .none,sound: .propellerPlaneNoise, animationType: .agile_slow_plane)


let su27 = Aircraft(name: "Su-27", origin: .russia, yearIntroduced: 1985, status: .active, Manufacturer: "Sukhoi", description: """
The Sukhoi Su-27, known by its NATO reporting name “Flanker,” is a twin-engine, highly maneuverable air superiority fighter developed by the Soviet Union’s Sukhoi Design Bureau in the 1970s. The Su-27 was designed to counter the emerging threat of advanced Western fighters like the F-15 Eagle and F-16 Fighting Falcon, providing the Soviet Air Force with a platform capable of achieving air dominance. Entering service in 1985, the Su-27 quickly became one of the most iconic and formidable fighters of its time, praised for its agility, speed, and advanced avionics, and serving as the foundation for an entire family of fighter variants.

The Su-27 features a large, aerodynamically refined design with a blended wing-body configuration, canards (in some variants), and twin vertical stabilizers that contribute to its superior agility and stability during high-performance maneuvers. The aircraft is powered by two Saturn AL-31F afterburning turbofan engines, which enable it to reach speeds of up to Mach 2.35 and an operational ceiling of 62,000 feet (18,900 meters). The Su-27’s high thrust-to-weight ratio, advanced aerodynamics, and fly-by-wire control system allow it to perform highly dynamic maneuvers, including the famous Pugachev’s Cobra, a high-angle-of-attack maneuver that demonstrates the aircraft’s exceptional handling characteristics.

Equipped with advanced avionics and radar systems, the Su-27 was originally fitted with the N001 Myech radar, capable of detecting and tracking multiple targets at long ranges. The aircraft’s targeting systems were designed to engage both air and ground targets, enhancing its versatility as a multirole fighter. The cockpit is fitted with a head-up display (HUD) and multifunction displays that provide critical flight and combat information, allowing pilots to maintain situational awareness during engagements.

Historically, the Su-27 played a significant role in reshaping Soviet and later Russian air power during the Cold War and beyond. It was designed to provide air superiority over vast battlefields, protecting Soviet airspace from incursions by NATO forces and securing dominance in aerial engagements. The aircraft’s agility, speed, and powerful weapon systems made it a formidable adversary, and it quickly gained a reputation as one of the most capable fighters of its era.

The Su-27’s influence extended well beyond its initial role as an interceptor. It became the foundation for a broad family of variants, including the Su-30, Su-33, Su-34, and Su-35, each incorporating advancements in avionics, weapons, and mission capabilities. These derivatives have seen widespread export, serving with numerous air forces around the world, including China, India, and several other nations, further cementing the Su-27’s legacy as a versatile and highly effective fighter platform.
"""
                    , topSpeed: 1553, modelPathName: "su27",sound: .jetPlaneNoise, animationType: .agile_fast_plane)

let spitfire = Aircraft(name: "Spitfire", origin: .uk, yearIntroduced: 1938, status: .notActive, Manufacturer: "Supermarine", description: """
The Supermarine Spitfire is a British single-seat fighter aircraft that became one of the most iconic and celebrated fighters of World War II. Designed by R.J. Mitchell of Supermarine in the 1930s, the Spitfire was renowned for its speed, agility, and exceptional handling characteristics, making it a formidable adversary in dogfights. Introduced in 1938, the Spitfire served as the backbone of the Royal Air Force’s (RAF) fighter force throughout the war, playing a crucial role in defending Britain during pivotal moments such as the Battle of Britain.

The Spitfire features an elegant design with elliptical wings that not only gave it a distinctive look but also contributed to its excellent aerodynamics. Powered initially by the Rolls-Royce Merlin engine, and later by the more powerful Rolls-Royce Griffon engine in advanced versions, the Spitfire could reach speeds of over 360 mph (580 km/h) and operate at altitudes of up to 36,000 feet (10,970 meters). Its light, all-metal airframe, combined with the high-performance engine, gave the Spitfire superb acceleration and maneuverability, allowing it to outturn many of its adversaries.

Equipped with a variety of armament configurations throughout its service, the Spitfire was initially fitted with eight .303 Browning machine guns. Later versions were upgraded with heavier armament, including 20mm Hispano cannons and 12.7mm (.50 caliber) machine guns, enhancing its effectiveness against both enemy fighters and bombers. The aircraft’s firepower, combined with its agility, made it one of the most lethal fighters in the skies.

The Spitfire’s historical significance is most prominently highlighted during the Battle of Britain in 1940, where it, alongside the Hawker Hurricane, formed the core of the RAF’s defense against the Luftwaffe. Its speed, agility, and rapid climb rate were instrumental in intercepting and destroying German bombers and fighters, playing a crucial role in preventing a Nazi invasion of Britain. The Spitfire’s performance and the bravery of its pilots became a symbol of British resilience and determination during one of the war’s darkest periods.

The Spitfire’s enduring legacy is defined by its contributions to the Allied victory in World War II, its beautiful design, and the heroism of the pilots who flew it. It is widely regarded as one of the greatest fighter aircraft of all time, representing a perfect blend of engineering excellence and combat effectiveness. Even today, restored Spitfires continue to fly at airshows, reminding generations of the aircraft’s pivotal role in history and its symbolic representation of freedom and perseverance in the face of adversity.
""", topSpeed: 369, modelPathName: "spitfire", emitter: .none, sound: .propellerPlaneNoise, animationType: .agile_slow_plane)

let Osprey = Aircraft(name: "V-22 Osprey", origin: .america, yearIntroduced: 1989, status: .active, Manufacturer: "Bell Helicoper, Boeing Defense", description: """
The Bell Boeing V-22 Osprey is a tilt-rotor military aircraft developed as a result of the failure of Operation Eagle Claw in 1980, which underscored the need for an aircraft capable of both vertical takeoff and landing (VTOL) and high-speed, long-range flight. The Joint-service Vertical take-off/landing Experimental (JVX) program was initiated in 1981 by the United States Department of Defense (DoD) to address this need. Bell Helicopter and Boeing Helicopters were awarded a development contract in 1983, leading to the first flight of the V-22 prototype in 1989. The complexity of being the first tilt-rotor aircraft for military service resulted in extensive flight testing and design alterations over the years.

The United States Marine Corps (USMC) began crew training for the MV-22B Osprey in 2000, with the aircraft being fielded in 2007. The USMC employed the Osprey to supplement and eventually replace their Boeing Vertol CH-46 Sea Knights. Similarly, the United States Air Force (USAF) introduced its version of the tilt-rotor, the CV-22B, in 2009. Since its introduction, the Osprey has been deployed in various operations, including transportation and med-evac missions over Iraq, Afghanistan, Libya, and Kuwait. The U.S. Navy also began using the CMV-22B variant for carrier onboard delivery duties in 2021.

The development of the V-22 faced controversies and challenges, including significant cost increases, safety concerns, and maintenance issues. However, various improvements and upgrades have been made over the years to enhance the aircraft's reliability and effectiveness. The V-22 Osprey features a tilt-rotor design, allowing it to perform both vertical takeoff and landing (VTOL) and conventional fixed-wing flight. This unique design enables the aircraft to operate in diverse environments and fulfill various mission requirements effectively.

In addition to its versatile design, the V-22 can be armed with machine guns and missile systems for self-defense purposes. Efforts have also been made to develop aerial refueling capabilities for the V-22, allowing it to refuel other aircraft in mid-flight and extend its operational range and versatility further. These advancements have solidified the V-22 Osprey's position as a critical asset in modern military operations, providing a unique combination of capabilities that traditional helicopters or fixed-wing aircraft alone cannot match.
""", topSpeed: 316, modelPathName: "osprey", emitter: .none, sound: .helicopterNoise, animationType: .large_slow_plane, needToPurchase: true)



let mig23 = Aircraft(name: "MiG 23", origin: .ussr, yearIntroduced: 1970, status: .notActive, Manufacturer: "Mikoyan-Gurevich", description: """
The Mikoyan-Gurevich MiG-23, designated as "Flogger" by NATO, was a Soviet variable-sweep wing fighter aircraft that played a significant role during the Cold War era. Designed by the Mikoyan-Gurevich Design Bureau, the MiG-23 was developed to be a versatile frontline fighter capable of a range of missions.

Featuring a distinctive swing-wing design, the MiG-23 possessed the ability to adjust its wing sweep angle during flight, allowing it to optimize performance for different flight regimes. This design flexibility enabled the aircraft to excel in both high-speed intercepts and close-quarters dogfights.

Powered by a potent turbojet engine, the MiG-23 could attain speeds reaching Mach 2.35. It was armed with an array of weapons, including radar-guided and infrared-guided air-to-air missiles, as well as a built-in 23mm cannon for close-range engagements.

The MiG-23 served in multiple variants, including ground-attack and reconnaissance roles. Its deployment marked an important phase in the Cold War arms race, reflecting the Soviet Union's commitment to developing advanced fighter aircraft with adaptable capabilities.

Though the MiG-23 faced maintenance challenges and complexities, it participated in several conflicts, including the Iran-Iraq War and the Soviet-Afghan War. Over time, its service spanned multiple roles, reflecting its contribution to Soviet air power.

The Mikoyan-Gurevich MiG-23's legacy lives on as a representation of the technological innovation and strategic planning of its era. Its unique swing-wing design and multirole capabilities underline its significance in Cold War aviation history.
""", topSpeed: 1800, modelPathName: "mig23Flogger",sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)

let Tu28 = Aircraft(name: "Tu-28", origin: .ussr, yearIntroduced: 1964, status: .notActive, Manufacturer: "Voronezh Aircraft Production Association", description: """
The Tupolev Tu-28, also known by its NATO reporting name “Fiddler,” holds a significant place in Cold War aviation history as the largest and heaviest interceptor ever built, specifically designed to defend the vast and remote northern and eastern frontiers of the Soviet Union. Developed by the Tupolev Design Bureau, the Tu-28 was introduced in the early 1960s during a period when the Soviet Union faced a critical need to counter the growing threat of high-speed Western bombers and reconnaissance aircraft that could penetrate deep into Soviet airspace. Its role was vital in the strategic defense of the Soviet Union’s extensive borders, filling a unique niche in Soviet air defense strategy.

The Tu-28's development marked a departure from traditional interceptor design due to its sheer size and long-range capabilities, which were driven by the need to patrol enormous expanses of airspace where traditional fighter cover and ground-based radar support were sparse. Powered by two Lyulka AL-7F-2 afterburning turbojet engines, the Tu-28 could reach speeds of Mach 1.6 and had an operational ceiling of 53,000 feet (16,150 meters). Its impressive range of approximately 1,200 miles (1,930 km) without refueling allowed it to undertake extended missions far from support bases, a critical requirement given the vastness of the Soviet Union.

The aircraft was equipped with the RP-11 “Oriol-D” (NATO: Foxfire) radar, one of the most powerful intercept radars of its time, capable of detecting targets at great distances, even in the Arctic regions where it often operated. Armed primarily with R-4 (AA-5 “Ash”) long-range missiles, the Tu-28 was designed to intercept and destroy incoming threats before they could approach Soviet airspace. Its emphasis on missile engagement over traditional dogfighting reflected its strategic role, as it was primarily intended to shoot down enemy bombers and reconnaissance aircraft, rather than engage in close-range combat.

The Tu-28’s service extended into the late 1980s, highlighting the enduring strategic value it provided during a critical era in global military aviation. Its eventual replacement by more advanced interceptors like the MiG-31 Foxhound marked the end of an era but underscored the Tu-28’s role in bridging the gap between early jet interceptors and the more sophisticated systems that followed. The Tu-28 remains a testament to the unique challenges of Cold War air defense and the lengths to which the Soviet Union went to protect its expansive territory.
""", topSpeed: 1040, modelPathName: "Tu28", sound: .jetPlaneNoise, animationType: .large_fast_plane)

let Yak_28 = Aircraft(name: "Yak-28", origin: .ussr, yearIntroduced: 1960, status: .notActive, Manufacturer: "Yakovlev", description: """
The Yakovlev Yak-28, known by its NATO reporting name “Brewer,” is a twin-engine, multi-role jet aircraft developed by the Soviet Union during the Cold War. Designed by the Yakovlev Design Bureau, the Yak-28 served in a variety of roles, including tactical bomber, reconnaissance, electronic warfare, and interceptor, reflecting the Soviet Union’s need for a versatile aircraft capable of adapting to multiple combat scenarios. First introduced in the early 1960s, the Yak-28 played a crucial role in Soviet military aviation, particularly in tactical strike and air defense missions during a period of intense Cold War tensions.

The Yak-28 featured a distinctive design with sharply swept wings, a high-mounted tailplane, and a pair of large engine nacelles mounted on pylons under the wings, housing two Tumansky R-11 turbojet engines. These engines provided the aircraft with a maximum speed of around 1,150 mph (Mach 1.1) and an operational ceiling of approximately 50,000 feet (15,240 meters), allowing it to perform high-speed interdiction and ground-attack missions. The aircraft's agility and speed made it a capable performer in its various roles, from high-speed bombing runs to intercepting enemy aircraft.

One of the notable aspects of the Yak-28’s design was its versatility, as it was adapted into multiple variants tailored for different missions. The Yak-28B was the bomber version, equipped with a large internal weapons bay capable of carrying bombs, rockets, and even nuclear payloads, making it a critical asset for tactical strikes. The Yak-28P variant served as an interceptor, fitted with advanced radar systems and armed with air-to-air missiles to defend against intruding bombers. Other variants included the Yak-28R for reconnaissance missions and the Yak-28PP, which was developed for electronic warfare and jamming enemy radar and communications, showcasing the aircraft’s adaptability to evolving military needs.

The Yak-28’s radar systems, such as the “Skip Spin” and later “Eagle” radars on the interceptor versions, provided significant target acquisition and tracking capabilities, enhancing the aircraft’s effectiveness in air defense roles. While its avionics were relatively basic compared to Western standards, the Yak-28’s systems were designed for the robust and reliable. The aircraft’s armament varied by role, with bomber versions carrying bombs and rockets, while interceptor variants were equipped with air-to-air missiles, such as the K-8 (AA-3 “Anab”) missiles.

The Yak-28’s operational history includes numerous deployments in key Soviet areas, where it was tasked with high-speed reconnaissance, electronic warfare, and air defense missions. Although not as widely known as some of its contemporaries, the Yak-28 was a workhorse of the Soviet air forces, often operating in harsh conditions and serving as a deterrent against NATO forces. Its various roles throughout the Cold War highlight the aircraft’s importance in maintaining Soviet air superiority and tactical flexibility during a critical period of global military competition.
""", topSpeed: 1140, modelPathName: "Yak28", emitter: .none, sound: .jetPlaneNoise, animationType: .large_fast_plane, needToPurchase: true)


let DassaultRafale = Aircraft(name: "Dassault Rafale", origin: .france, yearIntroduced: 2001, status: .active, Manufacturer: "Dassault Aviation", description:
"""
The Dassault Rafale is a French twin-engine, multirole fighter aircraft developed by Dassault Aviation for the French Air Force and Navy. Designed to perform a wide range of missions, including air superiority, ground attack, reconnaissance, and nuclear strike, the Rafale is known for its versatility, advanced technology, and exceptional maneuverability. Introduced into service in 2001, the Rafale represents a major leap in European fighter design, combining cutting-edge avionics, stealth features, and robust combat capabilities, making it one of the most capable and respected fighters in the world.

The Rafale is armed with a versatile arsenal that includes a 30mm GIAT 30 internal cannon, air-to-air missiles such as the MICA and Meteor, air-to-ground munitions like the SCALP EG cruise missile, and laser-guided bombs. Its ability to carry and deliver nuclear-capable ASMP-A missiles underscores its strategic role in France’s nuclear deterrent. The Rafale’s multirole capability allows it to transition seamlessly between missions, making it adaptable for everything from air defense to deep strike, close air support, and naval operations.

One of the Rafale’s defining features is its “Omnirole” capability, meaning it can perform multiple types of missions within a single flight, giving it unmatched flexibility on the battlefield. Its robust avionics, sensor fusion, and ability to operate from aircraft carriers with the Rafale M variant further enhance its operational versatility, supporting both land and sea-based deployments.

The development of the Rafale's traces back to the mid-1970s when the French Air Force and Navy sought a next-generation fighter aircraft to replace aging fleets. Initially, collaborative efforts were made with other European nations to create a common fighter aircraft which would later become the Eurofighter Typhoon. However, due to differing operational requirements and a desire to preserve technological independence, France ultimately pursued an independent path, opting out of the joint development union.

 This decision led to the inception of the Rafale program, which saw its first flight in 1986 and entered operational service in 2001. Since then, the Rafale has become a cornerstone of French military power, serving both the French Air and Space Force and the French Navy with distinction. Beyond its domestic deployments, the Rafale has found favor among international partners, with countries like Egypt, India, and Qatar incorporating it into their air forces. Its combat power has been demonstrated in conflicts across the globe, including engagements in Afghanistan, Libya, Mali, Iraq, and Syria, underscoring its effectiveness in modern warfare scenarios.
""", topSpeed: 1535, modelPathName: "DassaultRafale", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: false)



//let F5F = Aircraft(name: "Northrop F-5", origin: .america, yearIntroduced: 1964, status: .active, Manufacturer: "Northrop", description: """
//The Northrop F-5 family comprises supersonic light fighter aircraft that originated as a privately funded project by Northrop Corporation in the late 1950s. It includes the original F-5A and F-5B Freedom Fighter variants and the significantly updated F-5E and F-5F Tiger II variants. The design aimed to create a compact, highly maneuverable fighter with a low cost of maintenance, achieved by wrapping a small, aerodynamic frame around two powerful General Electric J85 engines.
//
//While smaller and simpler than contemporaries like the McDonnell Douglas F-4 Phantom II, the F-5 boasted cost-effectiveness in procurement and operation, making it a popular choice for export. Initially geared toward air superiority, it evolved into a capable ground-attack platform, entering service in the early 1960s. Over 800 were produced through 1972 for US allies during the Cold War era.
//
//In 1972, after winning the International Fighter Aircraft Competition, Northrop introduced the second-generation F-5E Tiger II, featuring enhancements such as more powerful engines, increased fuel capacity, and improved avionics. Over 1,400 Tiger IIs were built before production ceased in 1987, with the type serving in a wide range of roles and seeing extensive use in conflicts like the Vietnam War.
//
//The F-5's influence extended beyond its variants, serving as the basis for reconnaissance aircraft like the RF-5 Tigereye and inspiring design studies for subsequent aircraft such as the Northrop YF-17 and the F/A-18 naval fighter. Despite being a successful export product, advanced variants like the Northrop F-20 Tigershark, intended to succeed the F-5E, never materialized due to lack of export customers.
//
//Led by Northrop's vice president of engineering Edgar Schmued and chief engineer Welko Gasich, the F-5's design evolved through various iterations, emphasizing high performance, maneuverability, and cost-effectiveness. The project gained momentum in 1962 when it won the F-X competition, leading to widespread production and international adoption, including by the United States Navy, Republic of China Air Force, Republic of Korea Air Force, and Islamic Republic of Iran Air Force.
//""", topSpeed: 1083, modelPathName: "F5F", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: false)



let F111 = Aircraft(name: "F-111 Aardvardk", origin: .america, yearIntroduced: 1967, status: .notActive, Manufacturer: "General Dynamics", description: """
The F-111 Aardvark was a versatile, medium-range, supersonic combat aircraft developed by General Dynamics for the United States Air Force. Known for its pioneering variable-sweep wing design, the F-111 was used primarily as a tactical strike aircraft, reconnaissance platform, and electronic warfare aircraft. It was renowned for its speed, payload capacity, and groundbreaking avionics.

The F-111's most distinctive feature was its variable-geometry wings, which could sweep back for high-speed supersonic flight or extend forward for slower, more maneuverable operations during takeoff, landing, and low-level flight. This unique wing configuration provided the aircraft with exceptional versatility, allowing it to perform in a wide range of mission profiles, from high-speed strikes to terrain-following low-level bombing runs.

Powered by two Pratt & Whitney TF30 afterburning turbofan engines, the F-111 could reach speeds of up to Mach 2.5, making it one of the fastest strike aircraft of its time. Its twin-engine design, coupled with terrain-following radar, enabled the F-111 to fly at low altitudes at high speeds, avoiding radar detection and enemy defenses.

The F-111 was equipped with an internal weapons bay and could carry a variety of munitions, including conventional bombs, precision-guided weapons, and nuclear payloads. Its long-range and large payload capacity made it ideal for deep strike missions, where it could deliver devastating firepower far behind enemy lines.

The F-111 was a trailblazer in avionics, with a sophisticated terrain-following radar system that allowed the aircraft to automatically maintain a low-altitude flight path, even in poor visibility or adverse weather conditions. This capability made it particularly effective in strike missions, as it could fly under enemy radar coverage. Throughout its service life, the F-111 Aardvark played a key role in various conflicts, including the Vietnam War, the Gulf War, and numerous Cold War operations. Its combination of speed, range, and payload made it one of the most formidable strike aircraft of its era, leaving a legacy in military aviation history.
""", topSpeed: 1764, modelPathName: "F111", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)



let A6M = Aircraft(name: "A6M Zero", origin: .japan, yearIntroduced: 1940, status: .notActive, Manufacturer: "Mitsubishi", description: """
The Mitsubishi A6M Zero, commonly known simply as the Zero, was a long-range carrier-based fighter aircraft developed by Mitsubishi for the Imperial Japanese Navy. The Zero was renowned for its exceptional maneuverability, speed, and long-range capabilities, making it one of the most formidable fighters of the early years of World War II. Its design featured a lightweight airframe, retractable landing gear, and a powerful Nakajima Sakae radial engine, which allowed it to outmaneuver and outrun many Allied aircraft at the time.

The A6M Zero’s advanced design included thin, aerodynamically efficient wings and a lightweight construction that minimized weight without compromising structural integrity. It was armed with two 7.7mm machine guns and two 20mm cannons, giving it superb firepower for dogfights. The aircraft’s smooth, streamlined shape and minimal armor contributed to its speed and agility but also left it vulnerable to damage, especially from enemy fire.

The Zero had a combat range of over 1,100 miles, which was unmatched by contemporary fighters early in the war. Its exceptional performance allowed Japan to dominate the skies in the Pacific during the early years of the conflict, particularly during battles in the Philippines, and the early stages of the Guadalcanal Campaign.

However, as the war progressed, the Zero’s lack of armor and self-sealing fuel tanks became significant weaknesses against newer, more powerful Allied aircraft like the F6F Hellcat and the F4U Corsair. Despite these limitations, the A6M Zero remained in service throughout the war, adapting to various roles including kamikaze missions in the later stages.

The A6M Zero’s combination of speed, maneuverability, and range made it a symbol of Japanese air superiority early in World War II, and it remains one of the most iconic fighters of the era. Its design influenced the development of later aircraft and is remembered for its significant impact on aerial combat during the Pacific War.
""", topSpeed: 350, modelPathName: "A6M",emitter: .none, sound: .propellerPlaneNoise, animationType: .agile_slow_plane, needToPurchase: true)



let YE_8 = Aircraft(name: "Ye-8", origin: .ussr, yearIntroduced: 1962, status: .cancelled, Manufacturer: "Mikoyan-Gurevich", description: """
The Mikoyan-Gurevich Ye-8 was a Soviet experimental jet fighter developed in the 1960s as part of an effort to create a next-generation interceptor that could outperform existing designs, such as the MiG-21. Designed by the Mikoyan Design Bureau, the Ye-8 was an ambitious project that sought to integrate advanced technologies and improved aerodynamics to achieve superior speed, agility, and combat capability. Although it never entered production, the Ye-8 played a crucial role in the evolution of Soviet fighter design and contributed valuable insights that influenced later aircraft.

The Ye-8 featured a sleek, delta-wing configuration similar to the MiG-21 but with significant modifications, including canards mounted near the cockpit to enhance maneuverability and stability at high speeds. One of its most notable features was the redesigned nose, which incorporated an advanced radar system with a side-mounted intake, allowing the installation of a more powerful radar than those typically found in Soviet fighters at the time. This arrangement was intended to improve target acquisition and tracking capabilities, positioning the Ye-8 as a formidable air superiority platform.

The development of the Ye-8 was historically significant as it represented the Soviet Union’s push to innovate beyond the MiG-21, incorporating lessons learned from earlier fighters to create a more agile and capable aircraft. However, the program faced numerous technical challenges, including issues with the engine and intake design that led to dangerous aerodynamic problems. During flight testing, a catastrophic failure of the engine resulted in the loss of one prototype and the death of the test pilot, leading to the eventual cancellation of the program.

Despite its short-lived development, the Ye-8 provided valuable data on canard configurations, intake designs, and advanced radar integration, which informed future Soviet fighter programs. The lessons learned from the Ye-8’s design and testing influenced subsequent aircraft, including the MiG-23 and MiG-29, which incorporated similar concepts in more refined forms. The Ye-8 is remembered as a bold attempt to leap forward in Soviet fighter design, highlighting the challenges and risks associated with pushing the boundaries of aeronautical engineering during the Cold War.
""", topSpeed: 1650, modelPathName: "MIGE", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)




let F_117 = Aircraft(name: "F-117 Nighthawk", origin: .america, yearIntroduced: 1981, status: .notActive, Manufacturer: "Lockheed Corporation", description: """
The Lockheed F-117 Nighthawk is a single-seat, twin-engine stealth attack aircraft developed by Lockheed’s secretive Skunk Works division for the United States Air Force. Known as the world’s first operational stealth aircraft, the F-117 was designed to penetrate highly defended enemy airspace and deliver precision strikes with minimal risk of detection. Introduced in 1983 and publicly revealed in 1988, the Nighthawk represented a revolutionary leap in aviation technology, combining stealth, advanced avionics, and precision-guided munitions to perform highly secretive and strategic missions during its operational lifetime.

The F-117 features a distinctive, angular design with flat surfaces and sharp edges, a configuration specifically engineered to deflect radar waves away from enemy sensors, making it nearly invisible to radar detection. Its faceted shape, combined with radar-absorbent materials and coatings, gave the Nighthawk an exceptionally low radar cross-section, allowing it to operate deep within enemy territory.

The F-117’s cockpit was equipped with advanced avionics, including a digital fly-by-wire control system and sophisticated navigation and targeting systems. Its avionics suite was optimized for nighttime operations, with a heads-up display (HUD) and multi-function displays that provided critical flight and targeting information to the pilot. The aircraft was designed to operate primarily at night, taking advantage of the cover of darkness to further reduce the likelihood of detection.

The Nighthawk was armed exclusively with precision-guided munitions, including laser-guided bombs such as the GBU-10 Paveway II and GBU-27 Paveway III. These weapons were carried internally to maintain the aircraft’s stealth profile, and the F-117’s advanced targeting systems allowed it to deliver these bombs with pinpoint accuracy against high-value targets, such as enemy command centers, radar installations, and bunkers. Its ability to conduct surgical strikes with minimal collateral damage made the F-117 a critical asset for high-stakes missions.

The F-117 gained historic prominence during Operation Desert Storm in 1991, where it was used to strike key strategic targets in Iraq, demonstrating the effectiveness of stealth technology in combat for the first time. The Nighthawk’s ability to evade sophisticated air defenses and deliver precise strikes on heavily defended positions underscored the revolutionary impact of stealth in modern warfare. The aircraft was also used in other conflicts, including the Kosovo War, where it continued to perform high-risk missions that conventional aircraft could not safely execute.

The F-117’s operational history highlighted the game-changing role of stealth technology in the U.S. Air Force’s arsenal, providing a critical advantage in scenarios where conventional aircraft would face prohibitive risks. Its successes helped to pave the way for the development of other stealth aircraft, such as the B-2 Spirit and the F-22 Raptor, solidifying the importance of low-observable technology in future air combat.

Despite its groundbreaking capabilities, the F-117 was retired in 2008, as newer, more advanced stealth aircraft entered service. The Nighthawk’s retirement marked the end of an era but underscored its legacy as a pioneer of stealth technology and a symbol of American ingenuity in aerospace engineering. 
""", topSpeed: 684, modelPathName: "F_117", emitter: .none, sound: .jetPlaneNoise, animationType: .large_fast_plane, needToPurchase: false)



let F16 = Aircraft(name: "F-16 Fighting Falcon", origin: .america, yearIntroduced: 1978, status: .active, Manufacturer: "General Dynamics", description: """
The General Dynamics F-16 Fighting Falcon, now produced by Lockheed Martin, is a single-engine, multirole fighter aircraft originally developed in the 1970s for the United States Air Force. Known for its agility, speed, and versatility, the F-16 quickly became one of the most iconic and widely used fighters globally, serving in the air forces of over 25 countries. The F-16 was designed to be a lightweight, cost-effective air combat fighter capable of achieving air superiority and performing a wide range of missions, including ground attack, close air support, and reconnaissance. Since its introduction in 1978, the F-16 has played a significant role in numerous conflicts and remains one of the most produced fighter jets of the modern era.

The F-16 features a sleek, aerodynamic design with a distinctive bubble canopy that provides the pilot with excellent visibility, a critical advantage in dogfights. The aircraft’s relaxed static stability and fly-by-wire control system allow for exceptional maneuverability and responsiveness, making the F-16 highly agile in air-to-air combat. Powered by a single Pratt & Whitney F100 or General Electric F110 afterburning turbofan engine, the F-16 can reach speeds of over Mach 2 and has a maximum ceiling of about 50,000 feet (15,240 meters). Its high thrust-to-weight ratio and advanced aerodynamics enable it to execute tight turns and rapid accelerations, giving it a decisive edge in combat situations.

Throughout its operational history, the F-16 has been used extensively in various conflicts, including the Gulf War, the Balkans, Afghanistan, Iraq, and numerous other engagements worldwide. Its combat record and adaptability have solidified its reputation as a reliable and formidable fighter. The aircraft’s ease of maintenance, relatively low operating costs, and high availability rates have made it a preferred choice for many air forces around the world.

The F-16’s importance lies not only in its combat success but also in its impact on fighter design and production. It was one of the first fighters to incorporate fly-by-wire technology, setting new standards for agility and pilot control. Its development also influenced subsequent fighter designs, including the F-18 and F-35, shaping the future of combat aviation. With continuous upgrades and new production models, the F-16 remains a cornerstone of global air power, exemplifying the balance of performance, versatility, and affordability in modern military aviation.
""", topSpeed: 1545, modelPathName: "F16_Fixed", sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)



let SU25 = Aircraft(name: "Su-25", origin: .russia, yearIntroduced: 1981, status: .active, Manufacturer: "Sukhoi", description: """
The Sukhoi Su-25, affectionately known as the "Grach" (meaning "rook" in Russian), and designated as the "Frogfoot" by NATO, stands as a known defender in the category of close air support aircraft. Developed by Sukhoi in the Soviet Union, this subsonic, twin-engine jet aircraft was specifically engineered to provide air support to ground forces.

With its first prototype taking to the skies on February 22, 1975, the Su-25 entered series production in 1978, marking the beginning of its career. Over the years, various iterations and specialized variants emerged, each tailored to meet the demands of modern warfare.

Early versions of the Su-25 included the Su-25UB two-seat trainer, the Su-25BM for target-towing duties, and the Su-25K for export customers. Notably, the Su-25SM standard, introduced in 2012, brought significant upgrades to existing aircraft, ensuring they remained at the front of other fighters at the time.

Among the notable developments were the Su-25T and Su-25TM variants, designed for anti-tank missions, albeit not produced in significant numbers. The Su-25, alongside the Su-34, held the distinction of being the only armored fixed-wing aircraft in production in 2007.

Throughout its history, the Su-25 has seen combat in numerous conflicts, and showed its versatility and effectiveness. From the Soviet-Afghan War to the Syrian Civil War and the Russo-Georgian War, the Su-25 has earned the respect of both allies and adversaries.
"""
, topSpeed: 600, modelPathName: "SU25", emitter: .none, sound: .jetPlaneNoise, animationType: .large_slow_plane, needToPurchase: true)




let SU15 = Aircraft(name: "Su-15", origin: .ussr, yearIntroduced: 1962, status: .notActive, Manufacturer: "Sukhoi", description: """
The Sukhoi Su-15, known by its NATO reporting name “Flagon,” was a Soviet twin-engine, high-speed interceptor developed by the Sukhoi Design Bureau during the Cold War. Designed to defend the vast Soviet airspace against high-altitude intruders, including Western reconnaissance aircraft and bombers, the Su-15 played a critical role in Soviet air defense strategy from its introduction in 1965 until its retirement in the early 1990s. The aircraft was notable for its speed, range, and ability to intercept targets at high altitudes, helping to secure the Soviet Union’s borders during a period of intense geopolitical tension.

The Su-15 featured a sleek, delta-wing design with a mid-mounted wing configuration, large vertical stabilizers, and side-mounted engine intakes, which distinguished it from earlier Soviet interceptors. Powered by two Tumansky R-11F2S-300 turbojet engines, the Su-15 could reach speeds of up to Mach 2.5 and operate at altitudes of over 59,000 feet (18,000 meters). This high-speed performance enabled it to intercept high-altitude targets quickly, making it well-suited to counter strategic bombers, spy planes, and other aerial threats approaching Soviet airspace.

The Su-15 was armed with a variety of air-to-air missiles, including the R-8 (AA-3 “Anab”), R-98 (AA-3 “Anab”), and later variants like the R-60 (AA-8 “Aphid”) for close-range engagements. Some variants were equipped with a 23mm cannon for additional firepower. The aircraft’s emphasis on missile-based engagements rather than dogfighting reflected its primary mission of intercepting high-speed, high-altitude intruders rather than engaging in traditional air-to-air combat.

Historically, the Su-15 gained notoriety due to its involvement in several high-profile incidents, including the 1978 downing of Korean Air Lines Flight 902 and the more infamous shootdown of Korean Air Lines Flight 007 in 1983. These incidents highlighted the tense nature of Cold War airspace confrontations and underscored the Su-15’s role in Soviet air defense.

The Su-15’s operational history spanned nearly three decades, during which it was one of the principal interceptors defending Soviet airspace. It represented a significant step forward in Soviet interceptor design, offering a blend of speed, altitude, and advanced radar capabilities that made it a formidable defender against Western air threats. Although eventually replaced by more advanced aircraft like the MiG-31, the Su-15 played a key role during a critical period of the Cold War, providing a robust shield over the vast Soviet Union and contributing to the broader Soviet strategy of airspace control and deterrence. 
""", topSpeed: 1920, modelPathName: "SU15", sound: .jetPlaneNoise,  animationType: .agile_fast_plane, needToPurchase: false)


let hydra = Aircraft(name: "Harrier", origin: .uk, yearIntroduced: 1989, status: .notActive, Manufacturer: "British Aerospace, McDonnell Douglas", description: """
The British Aerospace Harrier II, also known as the AV-8B in the United States, is a second-generation vertical/short takeoff and landing (V/STOL) jet developed primarily for ground attack, close air support, and reconnaissance missions. Evolved from the original Hawker Siddeley Harrier, the Harrier II represents a significant upgrade with enhanced performance, avionics, and combat capabilities. Developed collaboratively by British Aerospace (later BAE Systems) and McDonnell Douglas (now part of Boeing), the Harrier II became a critical asset for the Royal Air Force, the U.S. Marine Corps, and other allied forces, distinguished by its ability to operate from short runways, improvised airstrips, and even from the decks of small aircraft carriers.

The Harrier II features a distinctive design with a high-mounted wing, twin forward air intakes, and four vectorable nozzles that allow the aircraft to hover, take off vertically, and perform short takeoffs and landings. Powered by a single Rolls-Royce Pegasus turbofan engine, the Harrier II can achieve speeds of up to 662 mph (Mach 0.85) and operate at altitudes up to 45,000 feet (13,700 meters). Its V/STOL capability enables it to deploy in forward areas closer to combat zones, providing rapid response and support to ground forces.

The Harrier II is armed with a wide array of weaponry, including a 25mm GAU-12/U Equalizer five-barrel rotary cannon mounted under the fuselage, and the ability to carry a mix of air-to-air missiles like the AIM-9 Sidewinder, guided bombs, rockets, and air-to-ground missiles such as the AGM-65 Maverick. Its flexibility in weapon loadouts allows it to perform a variety of combat roles, from engaging enemy aircraft to striking ground targets with precision-guided munitions. The aircraft's versatility extends to maritime strike roles, where it can operate effectively against naval threats.

Throughout its service, the Harrier II proved its worth in numerous conflicts, including the Falklands War, Operation Desert Storm, and the wars in Afghanistan and Iraq. Its ability to operate from austere locations and provide close air support was particularly valuable in these operations, where traditional airbases were often unavailable or too far from the battlefield. The Harrier II’s capability to perform vertical landings allowed it to return to carriers or forward operating bases that other aircraft could not utilize, making it a unique and highly flexible asset.

The historic significance of the Harrier II lies in its revolutionary approach to combat aviation, demonstrating the effectiveness of V/STOL technology in modern warfare. 
""", topSpeed: 750, modelPathName: "Hydra", emitter: .none, sound: .jetPlaneNoise, animationType: .large_fast_plane, needToPurchase: true)



let mig31 = Aircraft(name: "MiG-31", origin: .ussr, yearIntroduced: 1981, status: .active, Manufacturer: "Mikoyan", description: """
The Mikoyan MiG-31, known by its NATO reporting name “Foxhound,” is a supersonic, long-range interceptor developed by the Soviet Union’s Mikoyan Design Bureau to replace the MiG-25 Foxbat. Designed for high-speed interception of strategic bombers, reconnaissance aircraft, and cruise missiles, the MiG-31 is one of the fastest combat jets in the world, capable of operating in harsh environments and at extreme altitudes. Introduced in 1981, the MiG-31 remains a key element of Russia’s air defense system, providing unmatched speed, range, and firepower to protect vast stretches of Russian airspace.

The MiG-31 features a robust design with a large fuselage, twin engines, and a distinctive high-mounted, swept wing configuration. Powered by two Soloviev D-30F6 afterburning turbofan engines, the MiG-31 can achieve speeds of up to Mach 2.83 and fly at altitudes over 65,000 feet (20,000 meters). Its exceptional speed and climb rate enable it to rapidly intercept incoming threats, making it one of the few aircraft capable of countering high-speed targets like cruise missiles and supersonic bombers.

Armed with a formidable array of air-to-air missiles, the MiG-31 carries the long-range R-33 (AA-9 “Amos”) missiles specifically designed to engage large, high-value targets at great distances. Additionally, it can be equipped with R-77 (AA-12 “Adder”) medium-range missiles and R-73 (AA-11 “Archer”) short-range missiles for close combat. The MiG-31’s powerful armament is complemented by its internal 23mm GSh-6-23M cannon, although it relies primarily on its missiles to neutralize threats beyond visual range.

The MiG-31 was specifically designed to protect the vast and sparsely populated regions of the Soviet Union, such as the Arctic and Siberia, where ground-based radar coverage is limited. Its ability to operate from remote airfields and its long-range endurance make it uniquely suited for patrolling these extensive areas. The aircraft’s capability to perform mid-air refueling further extends its operational reach, allowing it to cover vast distances and maintain air patrols for extended periods.

Historically, the MiG-31 has played a critical role in defending Russian airspace from potential incursions, providing a deterrent against both strategic bombers and advanced reconnaissance platforms. Its speed and long-range missile capabilities have made it a cornerstone of Russia’s air defense strategy, capable of intercepting targets before they can pose a threat to key military or civilian infrastructure. The aircraft has undergone several upgrades, including the MiG-31BM variant, which features enhanced avionics, new radar, and improved weapon systems, ensuring its continued effectiveness in modern air combat.
""", topSpeed: 2171, modelPathName: "mig31", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)


let Bayraktar_TB2 = Aircraft(name: "Bayraktar", origin: .turkey, yearIntroduced: 2014, status: .active, Manufacturer: "Baykar", description: """
The Bayraktar TB2 is a medium-altitude, long-endurance (MALE) unmanned combat aerial vehicle (UCAV) developed by the Turkish company Baykar. Known for its role in modern asymmetric warfare, the Bayraktar TB2 has become one of the most influential and widely recognized drones of its kind, providing intelligence, surveillance, reconnaissance, and precision strike capabilities. Since its introduction in 2014, the TB2 has been deployed in numerous conflicts, demonstrating its effectiveness in combat and altering the dynamics of modern warfare.

The development of the TB2 was driven by a need for indigenous combat UAV capability after the U.S. banned exports of similar aircraft to Turkey. Despite initial reliance on imported components, Turkish industry has rapidly developed domestic alternatives, ensuring continuity in production and operation.

The Bayraktar TB2 features a distinctive design with a high-mounted, inverted V-tail configuration and a pusher propeller. It is powered by a Rotax 912 engine, allowing it to achieve a cruising speed of around 80 knots (150 km/h) and an operational altitude of up to 27,000 feet (8,230 meters). The TB2 has a maximum endurance of over 24 hours, making it suitable for extended surveillance and strike missions. The drone’s relatively lightweight, compact design allows for easy deployment and rapid assembly, making it adaptable to a wide range of operational environments.

The TB2’s combat capabilities are underscored by its ability to carry smart munitions, such as the Turkish-made MAM-L and MAM-C laser-guided missiles. These precision-guided bombs enable the TB2 to conduct targeted strikes against enemy positions, armored vehicles, artillery, and other high-value targets with minimal collateral damage. The drone’s armament and strike capability make it a versatile tool for both counterinsurgency and conventional military operations.

The Bayraktar TB2 has played a significant role in multiple conflicts, including operations in Syria, Libya, Nagorno-Karabakh, and Ukraine. Its effectiveness in disabling enemy armor, air defense systems, and supply lines has demonstrated the value of armed drones in modern warfare. 
""", topSpeed: 140, modelPathName: "Bayraktar", emitter: .none, sound: .propellerPlaneNoise, animationType: .agile_slow_plane, needToPurchase: true)


let fi56 = Aircraft(name: "Fi 156 Storch", origin: .naziGermany, yearIntroduced: 1937, status: .notActive, Manufacturer: "Fieseler", description: """
The Fieseler Fi 156 Storch (German for “Stork”) is a German light reconnaissance and liaison aircraft developed in the late 1930s by Fieseler for the Luftwaffe. Known for its remarkable short takeoff and landing (STOL) capabilities, the Storch became one of the most iconic and versatile aircraft of World War II, serving in a variety of roles including reconnaissance, medical evacuation, artillery spotting, and command transport. Its distinctive high-wing design, exceptional maneuverability, and ability to operate from improvised airstrips made the Fi 156 an invaluable asset on the front lines.

The cockpit of the Storch was designed with large glass windows and a high canopy, providing exceptional visibility for the pilot and observers, which was crucial for reconnaissance and spotting missions. The aircraft typically had a crew of two or three, depending on the mission, and was equipped with basic radio equipment for communication and navigation. The Fi 156’s exceptional field of view and slow flight characteristics made it highly effective for directing artillery fire and performing observation duties, as well as for quick medical evacuations from the battlefield.

One of the most famous uses of the Storch was during the daring rescue of Italian dictator Benito Mussolini in 1943. German commandos, led by Otto Skorzeny, used a Fi 156 to extract Mussolini from a mountaintop hotel, demonstrating the aircraft’s unparalleled capability to land in and take off from incredibly confined spaces. The Storch also played a critical role in countless other missions, including liaison duties, transporting high-ranking officers, and delivering vital supplies to isolated units.

The Fi 156’s versatility made it a mainstay for the German military throughout the war, serving on nearly every front, from the deserts of North Africa to the frozen landscapes of the Eastern Front. It was used by various Luftwaffe units, as well as by Axis and Allied forces who captured and repurposed the aircraft due to its unique capabilities. Its ability to operate in diverse environments and provide rapid, reliable support to ground forces set it apart as one of the most effective utility aircraft of the era.

Even after the war, the Storch’s design continued to inspire other aircraft, such as the French-built Morane-Saulnier MS.500 Criquet, which was a direct post-war production of the Fi 156. Today, restored Storches remain popular at airshows, celebrating the aircraft’s remarkable capabilities and its role as one of the most versatile and recognizable aircraft of World War II.
""", topSpeed: 110, modelPathName: "Fi56", emitter: .none, sound: .propellerPlaneNoise, animationType: .agile_slow_plane, needToPurchase: false)


let Etrich_Taube = Aircraft(name: "Etrich Taube", origin: .austria, yearIntroduced: 1910, status: .notActive, Manufacturer: "Various", description: """
The Etrich Taube, renowned for its distinctive design, was a pioneering monoplane aircraft developed by Austrian engineer Igo Etrich in 1909. Initially known as the Etrich-Rumpler Taube due to subsequent manufacturing by various companies, it gained fame as the first mass-produced military aircraft in Germany. Despite its name, "Taube" (German for "dove"), its wing shape was inspired by seeds rather than the bird itself. Featuring a unique crosswind-capable main landing gear and wing warping for lateral control, the Taube boasted stable flight characteristics ideal for observation.

Before World War I, the Taube enjoyed widespread popularity and was utilized by air forces in Germany, Italy, and Austria-Hungary. Notably, Italian aviator Giulio Gavotti made history in 1911 by dropping the world's first aerial bomb from a Taube over Libya. However, as warfare evolved, the Taube's limitations became apparent, leading to its gradual replacement by more advanced aircraft designs.

During World War I, Taube aircraft saw action in reconnaissance, surveillance, and bombing roles. Despite its stable flight, the Taube's poor maneuverability and vulnerability to faster enemy aircraft led to its relegation to training duties early in the war. Nevertheless, it served as a training platform for many future German flying aces, highlighting its enduring legacy in aviation history.

Manufactured by multiple companies under various names, the Taube's widespread production resulted in numerous variations, making it challenging for historians to identify specific manufacturers. Nevertheless, its contribution to early aviation and its role in shaping military aircraft development during the pre-war era remain significant milestones in aviation history.
""", topSpeed: 60, modelPathName: "Etrich_Taube", emitter: .none, sound: .propellerPlaneNoise, animationType: .large_slow_plane, needToPurchase: true)




let TU160 = Aircraft(name: "Tu-160", origin: .ussr, yearIntroduced: 1987, status: .active, Manufacturer: "Tupolev", description: """
The Tupolev Tu-160, known by its NATO reporting name “Blackjack,” is a supersonic, variable-sweep wing heavy strategic bomber developed by the Tupolev Design Bureau in the Soviet Union during the Cold War. As the largest and heaviest supersonic bomber ever built, the Tu-160 is capable of delivering both conventional and nuclear payloads at long range, serving as a critical component of Russia’s strategic bomber force. First introduced in 1987, the Tu-160 remains the fastest and most powerful bomber in the world, known for its advanced technology, striking design, and immense payload capacity.

The Tu-160’s primary armament consists of a wide range of air-launched cruise missiles and precision-guided munitions. Its internal rotary missile bays can carry up to 12 Kh-55 (AS-15 “Kent”) or Kh-101/102 (conventional and nuclear) cruise missiles, designed for long-range precision strikes against strategic targets. The aircraft can also carry a variety of conventional bombs, expanding its versatility for non-nuclear missions. With its significant payload capacity of up to 88,000 pounds (40,000 kg), the Tu-160 can deliver a devastating array of weaponry in both strategic and tactical scenarios.

Historically, the Tu-160 was developed as a direct response to the U.S. B-1 Lancer, aiming to provide the Soviet Union with a high-speed, long-range bomber capable of penetrating advanced air defenses and delivering nuclear strikes deep within enemy territory. The Tu-160’s introduction represented a major leap in Soviet bomber capabilities, offering a combination of speed, range, and payload unmatched by any other strategic bomber of its time. Its role as a nuclear deterrent made it a central part of the Soviet and later Russian strategic triad, serving alongside land-based missiles and submarine-launched ballistic missiles.

The Tu-160 has continued to serve as a symbol of Russian airpower since the collapse of the Soviet Union, with modernization programs extending its operational life and enhancing its capabilities. These upgrades include improved avionics, more efficient engines, and enhanced weapons systems, ensuring the Tu-160 remains a formidable strategic asset in the Russian Air Force’s arsenal. The aircraft has been used in various strategic missions and exercises, demonstrating its ability to project power and serve as a key element of Russia’s long-range strike capabilities.

The Tu-160’s significance lies not only in its advanced design and performance but also in its strategic role as a deterrent force, capable of delivering a swift and powerful response in times of crisis. As one of the most advanced and recognizable bombers in the world, the Tu-160 continues to play a crucial role in maintaining Russia’s strategic bomber force, showcasing the enduring legacy of Soviet engineering and the ongoing evolution of strategic air power. Its combination of speed, range, and payload ensures that the Blackjack remains a potent symbol of Russia’s military might in the 21st century.
""", topSpeed: 1575, modelPathName: "TU160", emitter: .none, sound: .largePlaneNoise, animationType: .large_fast_plane, needToPurchase: false)




let mirage4000 = Aircraft(name: "Mirage 4000", origin: .france, yearIntroduced: 1979, status: .cancelled, Manufacturer: "Dassault Aviation", description: """
The Dassault Mirage 4000, also known as the Super Mirage 4000, is a French prototype twinjet fighter aircraft developed by Dassault-Breguet as an evolution of the Mirage 2000.

Distinctively larger and heavier than its predecessor, the Mirage 2000, the Mirage 4000 was powered by two SNECMA M53-2 turbofans. It featured small canards above the engine air intakes and a true bubble canopy, distinguishing it from the Mirage 2000 and earlier Mirage variants. However, both aircraft shared the delta wing design, semi-conical Oswatitsch-type air intakes, and similar general configuration.

The Mirage 4000 conducted its maiden flight on 9 March 1979. Dassault financed the development of the Mirage 4000 as a private venture. It was designed to fulfill roles as both a long-range interceptor and a fighter-bomber, comparable in size to the US F-15 Eagle.

However, in the early 1980s, Dassault terminated the Mirage 4000 program after the Royal Saudi Air Force ordered a large number of Panavia Tornado aircraft. Additionally, the potential customer base was further diminished when Iran, another potential customer, was lost due to political changes in 1979. With the French Air Force opting to focus on the Mirage 2000, Dassault found itself without sufficient customers to justify continued development of the Mirage 4000.

The sole Mirage 4000 prototype completed a total of 336 flights, with its final flight occurring on January 8, 1988. It was later moved to its permanent display location at the Musée de l'air et de l'espace (Paris Air and Space Museum) in November 1992.

Although the Mirage 4000 project was ultimately cancelled, the knowledge and experience gained from its development would later influence the design of the Dassault Rafale, another highly successful multirole fighter aircraft produced by Dassault Aviation.
""", topSpeed: 1765, modelPathName: "Mirage4000", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)



let xb70 = Aircraft(name: "XB-70", origin: .america, yearIntroduced: 1964, status: .experimental, Manufacturer: "North American Aviation", description: """
The North American Aviation XB-70 Valkyrie is a retired prototype version of the planned B-70 nuclear-armed, deep-penetration supersonic strategic bomber developed for the United States Air Force Strategic Air Command. Designed by North American Aviation (NAA) in the late 1950s to replace aging aircraft like the B-52 Stratofortress and B-58 Hustler, the XB-70 was a six-engined, delta-winged aircraft capable of cruising at Mach 3+ while flying at altitudes of 70,000 feet (21,000 m).

Initially conceived to be virtually invulnerable to interception due to its high speed and altitude, the introduction of Soviet surface-to-air missiles in the late 1950s raised doubts about the B-70's near-invulnerability. Consequently, the Air Force shifted its focus to low-level penetration missions to avoid missile detection, diminishing the B-70's advantage over existing aircraft like the B-52. Furthermore, with the rise of intercontinental ballistic missiles (ICBMs), crewed nuclear bombers were viewed as increasingly obsolete.

Despite political factors, including initial interest during the 1960 presidential campaign, the B-70 program was ultimately cancelled in 1961. However, two prototype aircraft, designated XB-70As, were built for research purposes. These aircraft, named Air Vehicle 1 and Air Vehicle 2, were utilized for supersonic test flights between 1964 and 1969.

The XB-70 Valkyrie was designed with advanced aerodynamics, including a delta wing and canard surface, and employed supersonic technologies developed for previous programs. Its six General Electric YJ93-GE-3 turbojet engines propelled it to speeds exceeding Mach 3. The XB-70 also utilized compression lift, generated by shock waves under its wings, to enhance its performance.

During its operational history, the XB-70 set numerous speed and altitude records, including sustained Mach 3 flight for 32 minutes. It was also involved in research programs, such as measuring sonic booms and investigating structural dynamics. However, the XB-70's last supersonic flight occurred on December 17, 1968, and its final flight was on February 4, 1969, when one prototype was transferred to the National Museum of the United States Air Force for display.

While the B-70 program was ultimately cancelled, the data and technologies developed during the XB-70's testing phase contributed to subsequent aircraft programs, including the B-1 bomber and the American supersonic transport program. Additionally, through espionage, the Soviet Union acquired valuable insights for their own Tu-144 supersonic transport program.
""", topSpeed: 2056, modelPathName: "xb70",emitter: .none, sound: .largePlaneNoise, animationType: .large_fast_plane, needToPurchase: true)



let B_52 = Aircraft(name: "B-52 Stratofortress", origin: .america, yearIntroduced: 1955, status: .active, Manufacturer: "Boeing", description: """
The Boeing B-52 Stratofortress was developed as a long-range, strategic bomber designed to carry nuclear and conventional weapons for the United States Air Force. Conceived during the early years of the Cold War, the B-52 was built to serve as a key component of the U.S. nuclear deterrent strategy, capable of delivering devastating payloads over intercontinental distances. First introduced in 1955, the B-52 has evolved into one of the most iconic and enduring aircraft in military history, with a service record spanning over six decades.

The B-52 was developed in response to the need for a bomber that could fly higher, faster, and farther than its predecessors, capable of reaching the Soviet Union from U.S. bases without the need for refueling. Initially envisioned as a high-altitude, subsonic bomber, the B-52’s design featured eight Pratt & Whitney turbojet engines mounted in four twin-engine pods under its swept wings, allowing it to achieve a top speed of around 650 mph (Mach 0.86) and an operational ceiling of 50,000 feet (15,240 meters). Its high payload capacity and long range of over 8,800 miles (14,160 km) without refueling made it a strategic asset capable of reaching targets across the globe.

Equipped with advanced navigation, radar, and bombing systems, the B-52 was designed to deliver a wide variety of weapons, including nuclear bombs, cruise missiles, and conventional ordnance. Its internal bomb bays and external pylons enable the B-52 to carry a staggering payload of up to 70,000 pounds, making it one of the most heavily armed aircraft ever built. The B-52 has been continuously upgraded with modern avionics, electronic countermeasures, and weapons systems, allowing it to remain relevant in contemporary combat operations.

The B-52 was initially built as part of the U.S. nuclear triad, designed to deliver nuclear payloads as a deterrent during the height of the Cold War. However, its versatility quickly became apparent, and the aircraft was adapted for conventional bombing missions, maritime strike, and close air support. The B-52 has participated in nearly every major U.S. conflict since its introduction, including the Vietnam War, the Gulf War, the wars in Afghanistan and Iraq, and numerous other operations, demonstrating its adaptability and enduring combat value.

It served as a key deterrent against Soviet aggression, with its presence alone acting as a powerful reminder of the United States' strategic reach and destructive capability. Over time, the B-52’s mission evolved to include conventional warfare, electronic warfare, and standoff missile delivery, highlighting its ability to adapt to the changing needs of modern military strategy.

Despite being over 60 years old, the B-52 remains in active service due to its robust design, ease of maintenance, and capacity for upgrades. Ongoing modernization programs, including new engines, avionics, and weapon systems, are expected to keep the B-52 operational into the 2050s, far beyond the lifespan of any other bomber in history. The B-52’s combination of endurance, firepower, and versatility has solidified its place as one of the most significant and enduring military aircraft ever built, exemplifying the U.S. Air Force’s ability to project power on a global scale.
""", topSpeed: 650, modelPathName: "b52", emitter: .none, sound: .largePlaneNoise, animationType: .large_slow_plane, needToPurchase: false)



let HO_220 = Aircraft(name: "Horten Ho 229", origin: .naziGermany, yearIntroduced: 1944, status: .notActive, Manufacturer: "Gothaer Waggonfabrik", description: """
The Horten Ho 229, also known as the Gotha Go 229 due to extensive redesign work by Gothaer Waggonfabrik, was a response to Hermann Göring's call for light bombers capable of meeting the demanding "3×1000" requirement; to carry 1,000 kilograms (2,200 lb) of bombs a distance of 1,000 kilometres (620 mi) with a speed of 1,000 kilometres per hour (620 mph).

Designed by the Horten brothers, Reimar and Walter, the Ho 229 was one of the first flying wing aircraft to be powered by jet engines. Its sleek and unconventional design aimed to minimize drag and maximize aerodynamic efficiency, making it a nimble adversary in the skies. During World War II, the Ho 229 pushed the boundaries of aircraft design for its time, with its innovative flying wing configuration and jet propulsion. The nearly complete H.IX V3 prototype was captured by the American military after the end of the war and shipped to the United States under Operation Paperclip, which lead to it now today being on display at the National Air and Space Museum.

One of the most interesting aspects of the Ho 229 is its alleged stealth capabilities. Reimar Horten himself mentioned the use of charcoal dust in the wood glue to absorb electromagnetic waves, potentially shielding the aircraft from radar detection. While this technology was planned for production aircraft, its effectiveness on the prototype remains a subject of debate and investigation.

In the tumultuous landscape of World War II aviation, the Horten Ho 229 stands out as a symbol of innovation. Its sleek design, powered by jet engines and devoid of conventional control surfaces, represented a leap forward in aircraft engineering. Despite facing challenges in production and competition from within the German military, the Ho 229 captured imaginations with its promise of speed, range, and perhaps even stealth.
""", topSpeed: 600, modelPathName: "ho220", emitter: .none, sound: .jetPlaneNoise, animationType: .agile_slow_plane, needToPurchase: true)



let globalHawk = Aircraft(name: "RQ-4 Global Hawk", origin: .america, yearIntroduced: 2001, status: .active, Manufacturer: "Northrop Grumman", description: """
The Northrop Grumman RQ-4 Global Hawk is a high-altitude, long-endurance (HALE) unmanned aerial vehicle (UAV) developed for intelligence, surveillance, and reconnaissance (ISR) missions. Designed to provide persistent, real-time coverage of large areas, the RQ-4 has become one of the most advanced and capable surveillance drones in the world. First introduced in 2001, the Global Hawk was developed to meet the U.S. Air Force’s need for a platform that could gather critical intelligence over vast distances without putting pilots at risk, playing a key role in modernizing ISR capabilities.

The Global Hawk features a distinctive design with a long, slender fuselage, high-aspect-ratio wings, and a V-tail configuration optimized for high-altitude flight. Powered by a single Rolls-Royce F137-RR-100 turbofan engine, the RQ-4 can cruise at altitudes of up to 60,000 feet (18,300 meters), well above the range of most surface-to-air threats, and stay airborne for more than 30 hours. This endurance and altitude capability allow the Global Hawk to cover extensive areas, providing near-continuous surveillance over strategic locations.

Equipped with a suite of advanced sensors, the Global Hawk can conduct wide-area surveillance and detailed target reconnaissance in real-time. Its sensor payload includes synthetic aperture radar (SAR), electro-optical/infrared (EO/IR) cameras, and signals intelligence (SIGINT) systems, enabling it to detect and track a wide range of targets, from moving vehicles to fixed installations, in all weather conditions, day or night. The data collected is transmitted via satellite links to ground stations, where it can be analyzed and distributed to commanders and decision-makers.

The RQ-4’s primary role is to provide strategic intelligence and situational awareness, supporting military operations, humanitarian missions, and disaster response efforts. Its ability to loiter over areas of interest for extended periods makes it invaluable for monitoring evolving situations, conducting battle damage assessments, and gathering intelligence that informs strategic planning. The Global Hawk has been used extensively in various conflicts, including operations in Iraq, Afghanistan, Libya, and Syria, where it has provided critical ISR support to U.S. and allied forces.

The development of the RQ-4 was driven by the increasing need for real-time intelligence in modern conflicts, where rapid decision-making is crucial. Its high-altitude operation provides a unique vantage point, making it difficult for adversaries to detect and intercept. The Global Hawk’s role in ISR has helped redefine how military and intelligence operations are conducted, emphasizing the growing importance of unmanned systems in the 21st-century battlefield.
""", topSpeed: 400, modelPathName: "globalHawk", emitter: .none, sound: .largePlaneNoise, animationType: .large_slow_plane, needToPurchase: false)




let gripen = Aircraft(name: "JAS 39 Gripen", origin: .sweden, yearIntroduced: 1996, status: .active, Manufacturer: "Saab AB", description: """
The Saab JAS 39 Gripen is a multirole fighter aircraft developed by the Swedish aerospace company Saab for the Swedish Air Force. Designed to perform air-to-air, air-to-ground, and reconnaissance missions, the Gripen combines advanced technology, high maneuverability, and low operating costs, making it one of the most versatile and cost-effective fighters in the world. First introduced in 1996, the Gripen has evolved into a highly capable platform that serves with several air forces globally, embodying the principles of adaptability, agility, and technological sophistication.

Equipped with cutting-edge avionics, the Gripen’s cockpit includes a wide-angle head-up display (HUD), multi-function displays, and a hands-on throttle and stick (HOTAS) control system, providing the pilot with enhanced situational awareness and ease of operation. The aircraft’s radar systems, initially the PS-05/A pulse-Doppler radar and later upgraded with active electronically scanned array (AESA) radars in newer variants, enable long-range target detection and tracking. The Gripen’s sensor fusion integrates data from multiple sources, improving its effectiveness in complex combat environments.

The Gripen’s armament is highly versatile, capable of carrying a wide range of weapons, including the IRIS-T and AIM-9 Sidewinder for short-range air-to-air engagements, the Meteor missile for beyond-visual-range combat, and various air-to-ground munitions such as guided bombs and rockets. The aircraft is also equipped with a 27mm Mauser BK-27 cannon for close combat. Its flexible weapon loadout allows it to adapt to various mission requirements, from air defense and interdiction to ground attack and reconnaissance.

One of the Gripen’s key strengths is its operational flexibility and ease of maintenance. Designed to operate from short, improvised runways and austere airbases, the Gripen can take off and land on highways, and its maintenance can be performed quickly by small ground crews, making it highly adaptable in dispersed operations. This capability is especially valuable for Sweden’s defense strategy, which emphasizes the ability to sustain air operations even in the event of infrastructure damage.

The Gripen represents a significant achievement in Swedish aerospace engineering, embodying Sweden’s commitment to maintaining an independent, high-tech defense industry. Its development was driven by the need for a modern, multirole fighter that could operate effectively within Sweden’s unique geographic and strategic context, providing a robust and flexible response to potential threats.
""", topSpeed: 1535, modelPathName: "gripen", emitter: .smoke, sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)



let SU57 = Aircraft(name: "Su-57", origin: .russia, yearIntroduced: 2020, status: .active, Manufacturer: "Sukhoi", description: """
The Sukhoi Su-57 is a fifth-generation, multi-role stealth fighter jet developed by Sukhoi, a division of the United Aircraft Corporation (UAC) in Russia. Designed for air superiority, ground attack, and electronic warfare missions, the Su-57 combines advanced stealth technology, cutting-edge avionics, and supermaneuverability to challenge Western fifth-generation fighters. Its blended wing-body design, composed of composite materials with sharp angles and flat surfaces, minimizes radar visibility, while internal weapon bays reduce its radar cross-section further, enhancing its stealth capabilities. The aircraft is powered by twin Saturn AL-41F1 engines, with future models set to use the more advanced Izdeliye 30 engines, providing better thrust, fuel efficiency, and supercruise capabilities, allowing the Su-57 to reach speeds of up to Mach 2.0 without afterburners.

The Su-57's avionics include the advanced N036 Byelka AESA radar, which enhances situational awareness and target tracking, alongside a 101KS Atoll electro-optical targeting system, missile approach warning systems, and the L402 Himalayas electronic countermeasures suite for robust self-defense. Its cockpit has a modern glass display system with touchscreens, a wide-angle HUD, and voice-activated controls, all designed to streamline pilot workload during missions. Armed with a variety of weapons, including air-to-air missiles like the R-77 and R-73, air-to-ground missiles such as the Kh-35 and Kh-59MK2, guided bombs, and a 30mm GSh-30-1 autocannon, the Su-57 can carry these internally to maintain stealth or externally when stealth is less critical.

Notable for its supermaneuverability, the Su-57’s thrust vectoring engines enable it to perform advanced aerial maneuvers such as high-angle-of-attack flight and quick turns, giving it an edge in close-range combat scenarios. The aircraft is further equipped with countermeasures like radar jamming and infrared decoys, enhancing its survivability against enemy threats. With an operational range of approximately 2,200 miles without refueling and the option for air-to-air refueling, the Su-57 is capable of long-range missions that penetrate advanced air defense systems. As Russia’s answer to Western stealth fighters, the Su-57 integrates stealth, speed, and advanced weaponry, making it a formidable contender in modern aerial warfare.

""", topSpeed: 1534, modelPathName: "SU57", sound: .jetPlaneNoise, animationType: .agile_fast_plane, needToPurchase: true)


let Y20 = Aircraft(name: "Y-20 Kunpeng", origin: .china, yearIntroduced: 2016, status: .active, Manufacturer: "Xi'an Aircraft Company", description: """
The Xian Y-20 Kunpeng is a large, strategic airlift transport aircraft developed by China’s Xian Aircraft Industrial Corporation, a division of the Aviation Industry Corporation of China (AVIC). Designed to enhance China’s military and humanitarian airlift capabilities, the Y-20 is a versatile, heavy-lift aircraft capable of transporting troops, vehicles, and oversized cargo across vast distances. As China’s first indigenous strategic airlifter, the Y-20 represents a significant step in China’s aviation technology, positioning it alongside other global heavy transport aircraft like the U.S. C-17 Globemaster III and the Russian Il-76.

The Y-20 features a high-wing design with four engines mounted on pylons beneath the wings, giving it the lift and power necessary for heavy cargo transport. The aircraft currently uses Russian D-30KP-2 engines, though future models are expected to be equipped with more advanced Chinese-made WS-20 engines, which will improve fuel efficiency, payload capacity, and overall performance. The Y-20’s robust landing gear, consisting of a multi-wheel bogie system, enables operations from a variety of airstrips, including unpaved and austere runways, enhancing its operational flexibility.

The aircraft’s maximum payload capacity is around 66 tons, making it capable of transporting armored vehicles or up to 300 troops in a single flight. A rear-loading ramp facilitates rapid loading and unloading of cargo, while the integrated cargo handling system ensures efficient operations.

Equipped with modern avionics, the Y-20 includes a fully digital cockpit with multifunction displays and advanced flight control systems, providing pilots with enhanced situational awareness and ease of operation. The aircraft also features a fly-by-wire control system, which improves handling and reduces pilot workload, particularly during complex maneuvers and challenging landing conditions.

With a maximum range of approximately 4,850 miles (7,800 km) without refueling, the Y-20 can operate over long distances. Its capability to refuel in-flight further extends its range, making it a vital asset for long-haul missions. The Y-20 Kunpeng embodies China’s growing aviation prowess and strategic reach, offering a robust platform that supports both military and humanitarian needs. 
""", topSpeed: 575, modelPathName: "Y20", emitter: .none, sound: .largePlaneNoise, animationType: .large_slow_plane, needToPurchase: true)



let J6 = Aircraft(name: "J-6", origin: .china, yearIntroduced: 1962, status: .notActive, Manufacturer: "Shenyang", description: """
The Shenyang J-6 is a Chinese-built, single-seat, twin-engine jet fighter that served as one of the backbone fighters of the People’s Liberation Army Air Force (PLAAF) during the Cold War era. Developed by the Shenyang Aircraft Corporation, the J-6 is a licensed variant of the Soviet MiG-19, the world’s first mass-produced supersonic fighter. First introduced in the late 1950s, the J-6 played a crucial role in China’s air defense strategy throughout the latter half of the 20th century, providing the PLAAF with its first indigenous supersonic jet fighter.

The J-6 features a conventional design with a mid-mounted wing and swept-back angles that optimize it for high-speed, low-altitude combat. Its fuselage is characterized by a slim, tubular shape with air intakes at the front, feeding its two turbojet engines. These engines, originally the Soviet RD-9B and later Chinese-made WP-6 engines, enable the J-6 to achieve a maximum speed of around Mach 1.3 and a combat radius of approximately 400 miles (650 km). Although less advanced compared to later fighters, the J-6’s impressive speed and acceleration made it a formidable opponent in close-range air combat.

The armament of the J-6 consists of three 30mm NR-30 cannons, providing a powerful punch in dogfights, along with provisions for air-to-air missiles and unguided rockets on wing-mounted pylons. It can also carry light bombs, making it capable of limited ground attack missions. The combination of heavy cannons and its high speed made the J-6 a lethal adversary in close-range engagements, although it lacked the beyond-visual-range capabilities of later jet fighters.

The J-6’s airframe is built from durable materials, designed to withstand the rigors of supersonic flight and combat maneuvering. The aircraft’s simple and robust construction contributed to its ease of maintenance, allowing it to operate effectively in various conditions with minimal ground support. Its operational ceiling of around 55,000 feet (16,700 meters) allowed it to perform high-altitude interceptions, although it was most effective at lower altitudes where its maneuverability excelled.

Throughout its service life, the J-6 was used extensively by China and exported to numerous countries, including Pakistan, Albania, and North Korea, where it served in various roles from frontline interceptor to ground-attack fighter. While it has been largely retired from active service, some nations continue to use the J-6 in training and secondary roles. The Shenyang J-6 represents an important chapter in Chinese aviation history, marking China’s early efforts to build a capable supersonic fighter fleet and providing valuable combat experience for its pilots during a critical period of military development.
""", topSpeed: 997, modelPathName: "J6", emitter: .none, sound: .jetPlaneNoise, animationType: .agile_slow_plane, needToPurchase: true)


let C20A = Aircraft(
    name: "C-20A",
    origin: .america,
    yearIntroduced: 1983,
    status: .active,
    Manufacturer: "Gulfstream Aerospace",
    description: """
The C-20A is a modified Gulfstream III business jet operated by NASA as an airborne science research platform. Acquired from the U.S. Air Force in 2002, the C-20A has been extensively modified to support environmental and geophysical studies, serving as a critical tool for NASA, government agencies, academia, and private industry. The aircraft features advanced systems like the UAVSAR (Uninhabited Aerial Vehicle Synthetic Aperture Radar), designed for detecting subtle Earth surface changes caused by phenomena like earthquakes, glacier movement, and volcanic activity. Mounted in a custom underbelly pod, the UAVSAR leverages interferometry for high-precision measurements and provides data for ecological and climate research.

The C-20A is equipped with the Data Collection and Processing System (DCAPS), which automates mission configuration and ensures reliable real-time data processing and distribution. The aircraft also features the Precision Platform Autopilot (PPA), a high-accuracy system developed by NASA Armstrong engineers. The PPA enables repeatable flight paths with an accuracy of 15 feet, ensuring consistent data collection for scientific missions. 

Powered by two Rolls-Royce Spey Mark 511-8 turbofan engines, the C-20A has a top speed of Mach 0.85, a maximum range of 3,400 nautical miles, and a service ceiling of 45,000 feet. Additional modifications include onboard internet connectivity, enhanced video systems, and an upgraded electrical power system to support scientific equipment. With its ability to refuel in-flight, the C-20A is ideal for long-duration missions, making it a vital asset for advanced scientific research and environmental monitoring.
""",
    topSpeed: 576,
    modelPathName: "C20_A",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: false
)

let DC8 = Aircraft(
    name: "DC-8",
    origin: .america,
    yearIntroduced: 1959,
    status: .active,
    Manufacturer: "McDonnell Douglas",
    description: """
NASA’s DC-8 Airborne Science Laboratory is a highly modified four-engine jetliner that has served as a premier flying laboratory for Earth science missions for more than 25 years. Operated by NASA’s Armstrong Flight Research Center in Palmdale, California, the DC-8 is used to collect data supporting a wide range of scientific research. Its capabilities include sensor development, satellite sensor verification, space vehicle launch and re-entry tracking, and other studies of Earth’s surface and atmosphere.

The DC-8 has been instrumental in missions such as Operation IceBridge, a polar ice field survey, and FIREX-AQ, a study of wildfires and their impact on air quality. It carries a suite of scientific instruments and can accommodate up to 45 researchers and flight crew, making it one of the most versatile airborne science platforms. Its extended range of 5,400 nautical miles and ability to fly at altitudes from 1,000 to 42,000 feet allow it to conduct long-duration missions, often lasting 6 to 10 hours.

Equipped with advanced communication systems, including Iridium and Inmarsat satellite capabilities, the DC-8 facilitates real-time data transmission and collaboration among scientists. It also supports live updates of meteorological data, messaging, and telemetry. The aircraft’s ability to test and verify satellite instruments and its adaptability for diverse research needs have made it a vital resource for the global scientific community.
""",
    topSpeed: 576,
    modelPathName: "DC8",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: false
)


let ER2 = Aircraft(
    name: "ER-2",
    origin: .america,
    yearIntroduced: 1981,
    status: .active,
    Manufacturer: "Lockheed Martin",
    description: """
NASA’s ER-2 is a high-altitude research aircraft operated by the Armstrong Flight Research Center, serving as a versatile platform for remote sensing and in-situ data collection. Derived from the U-2 reconnaissance aircraft, the ER-2 operates at altitudes of 70,000 feet, placing it above 95% of Earth's atmosphere. This vantage point allows its sensors to replicate the spatial, spectral, and atmospheric conditions of satellite instruments, making it invaluable for satellite calibration, data validation, and Earth science missions.

With an effective horizon of over 300 miles at maximum altitude, the ER-2 can capture expansive Earth imagery and conduct atmospheric soundings. It supports a wide range of missions, including studies of Earth’s resources, atmospheric chemistry, and oceanic processes. The aircraft also facilitates the development and testing of advanced electronic sensors and instruments for space and Earth applications.

The ER-2 is powered by a single jet engine and features a maximum payload capacity of 2,900 pounds. It provides 30 kVA of power for onboard instruments, supporting diverse mission requirements. Operating at speeds up to 410 knots, it has a range of 5,000 nautical miles and a mission duration of approximately 8 hours, depending on payload and weather conditions.

NASA currently operates two ER-2 aircraft, designated N806NA and N809NA, which entered service in 1981 and 1989, respectively. These aircraft continue to provide critical data for atmospheric and Earth science, advancing research on a global scale while supporting collaborations with international organizations and agencies.
""",
    topSpeed: 500,
    modelPathName: "ER_2",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: false
)

let G5 = Aircraft(
    name: "G-5",
    origin: .america,
    yearIntroduced: 1995,
    status: .active,
    Manufacturer: "Gulfstream",
    description: """
NASA’s Gulfstream GV is a long-range business jet operated by the Johnson Space Center (JSC) as part of a shared usage agreement between the International Space Station (ISS) Program and the NASA Earth Sciences Division (ESD). Acquired in September 2016, the Gulfstream GV serves dual roles: supporting the ISS Program’s Soyuz Direct and Commercial Crew Program Crew Return missions and facilitating airborne science missions in remote locations for NASA’s ESD. This collaboration builds upon the successful shared usage model established with JSC’s Gulfstream GIII aircraft.

The Gulfstream GV is equipped with advanced modifications to support scientific and medical missions. These include two centerline nadir-facing optical viewports, 8 configurable equipment racks (300 lbs max per rack), and an experimenter power system capable of providing 21 kVA at 115 VAC (60 Hz), 20 kVA at 115 VAC (400 Hz), and 10 kW at 28 VDC. Additionally, the aircraft features satellite communications systems such as Inmarsat and Iridium for voice and data, as well as a high-speed onboard network infrastructure capable of 10 Gbps.

The Gulfstream GV has a mission ceiling of 51,000 feet and a maximum airspeed of 507 knots at 41,000 feet (Mach 0.885). With a maximum fuel load of 41,300 lbs, the aircraft can sustain missions up to 12 hours in duration. The cabin payload capacity varies depending on the fuel load, ranging from 8,100 lbs with 36,000 lbs of fuel to 2,800 lbs with 41,300 lbs of fuel. 

Originally modified for medical care to support deconditioned astronauts, the GV has since been outfitted to meet the requirements of an airborne science platform. Enhancements include nadir-facing optical viewports for Earth observation, networked experimenter systems, and precision timing protocols like NTP and PTP. These capabilities make the Gulfstream GV a versatile and critical asset for NASA’s science and exploration missions.
""",
    topSpeed: 585,
    modelPathName: "G5",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: true
)


let P3 = Aircraft(
    name: "P-3 Orion",
    origin: .america,
    yearIntroduced: 1959,
    status: .active,
    Manufacturer: "Lockheed Martin",
    description: """
The NASA P-3 Orion, operated by the Wallops Flight Facility (WFF) Aircraft Office under the Goddard Space Flight Center (GSFC), is a four-engine turboprop aircraft tailored for endurance and range. The P-3 has supported a broad spectrum of scientific research, including meteorology, ecology, atmospheric chemistry, cryospheric research, oceanography, and soil science. This versatile aircraft also plays a vital role in satellite calibration and validation, as well as serving as a testbed for new airborne and satellite instrumentation.

Extensively modified for scientific research, the P-3 features zenith ports, three nadir ports, seven modified windows for external experiments, tail cone and nose radome ports, and ten wing-mounted experiment locations. The aircraft's unpressurized bomb bay can be converted into a custom fairing with two large nadir ports and several oblique ports for sensors and antennas. The P-3 is equipped with systems for dropsonde and sonobuoy deployment and can conduct aerial deployments with its functional bomb bay doors.

With a maximum payload capacity of 18,000 lbs and mission durations of up to 12 hours, the P-3 is ideal for long-duration and all-weather research missions. Its modern avionics include an upgraded cockpit and an Airborne Science Program network that provides data and video throughout the cabin. Connected to satellite constellations, the network enables uplink/downlink capability, internet access, flight tracking, and communication between aircraft and ground assets.

Operating at a maximum altitude of 32,000 feet and with a range of 3,800 nautical miles, the P-3 remains a reliable platform for global scientific endeavors. The GSFC/WFF Aircraft Office is committed to maintaining the P-3 as a safe, adaptable, and cost-effective resource for airborne research. Plans to transition ownership to NASA Langley in late FY25 will ensure its continued utility for future missions.
""",
    topSpeed: 475,
    modelPathName: "P3",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: true
)

let SIERRA = Aircraft(
    name: "SIERRA",
    origin: .america,
    yearIntroduced: 2018,
    status: .active,
    Manufacturer: "NASA",
    description: """
The Sensor Integrated Environmental Remote Research Aircraft (SIERRA) is a medium-class unmanned aircraft system (UAS) designed to perform remote sensing and atmospheric sampling missions in challenging and often inaccessible regions. These include mountain ranges, open oceans, and polar areas such as the Arctic and Antarctic. The SIERRA is particularly valuable for missions requiring long flight durations or operating in remote, hazardous environments where the presence of human pilots or high-value aircraft is impractical or risky.

Developed by NASA’s Ames Research Center and the U.S. Naval Research Laboratory, SIERRA is optimized for precise data collection. Its compact size allows it to operate from small runways and hangars, while its robust design accommodates up to 110 pounds of scientific payloads. The aircraft can reach altitudes of up to 13,000 feet and cruise at 60 knots, making it ideal for a variety of Earth science research missions. A typical mission includes carrying a 63-pound payload at 1,000 feet for nearly 9 hours.

The SIERRA program, managed at NASA Ames, provides comprehensive support for UAS missions, including experiment design, payload integration, airworthiness reviews, airspace access coordination, deployment planning, and mission operations. The program has facilitated numerous successful missions, with SIERRA-B beginning payload integration in November 2018. These missions advance Earth science research and applications, demonstrating the aircraft’s versatility and reliability.

With a range of 520 nautical miles and a gross take-off weight of 480 pounds, SIERRA is an essential tool for gathering environmental data in locations that are otherwise difficult to reach. Its robust capabilities and focus on operational safety ensure continued contributions to scientific discovery and understanding.
""",
    topSpeed: 80,
    modelPathName: "SIERRA",
    emitter: .none,
    sound: .propellerPlaneNoise,
    animationType: .agile_slow_plane,
    needToPurchase: true
)

let OTTER = Aircraft(
    name: "Twin Otter",
    origin: .canada,
    yearIntroduced: 1966,
    status: .active,
    Manufacturer: "De Havilland Canada",
    description: """
The NASA Twin Otter - GRC, based on the De Havilland Canada DHC-6 Twin Otter, is a rugged and versatile twin-engine turboprop aircraft designed to support a wide range of Earth science research missions. Operated by the Glenn Research Center (GRC), this aircraft is particularly suited for missions in challenging environments, such as polar regions, mountain ranges, and remote areas with short or unpaved runways.

The Twin Otter - GRC is equipped with advanced scientific instrumentation, including the in-house developed Hyperspectral Imager (HSI3.1), which collects three-dimensional hyperspectral data in the 400-900 nm wavelength range. This makes it ideal for applications like harmful algae identification and environmental monitoring. Additional instruments such as radar altimeters, lidar systems, and atmospheric sensors enable the study of sea ice elevation, soil moisture, ocean salinity, and ice sheet thickness.

As a modified DHC-6, this Twin Otter features a highly configurable design, including customizable payload accommodations and a variety of ports for externally mounted experiments. It has a payload capacity of 3,000 lbs and can sustain missions of up to 9 hours. The aircraft’s operational flexibility and ability to integrate multiple sensors make it a critical asset for NASA’s Earth Science campaigns.

With its 19.8-meter (65-foot) wingspan and robust performance capabilities, the Twin Otter - GRC continues to contribute to groundbreaking research in environmental monitoring and remote sensing. Its durable design and precision instrumentation ensure its ongoing utility in advancing our understanding of Earth’s systems.
""",
    topSpeed: 190,
    modelPathName: "OTTER",
    emitter: .none,
    sound: .largePropellerPlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: true
)


let WB57 = Aircraft(
    name: "WB-57",
    origin: .america,
    yearIntroduced: 1954,
    status: .active,
    Manufacturer: "Martin Company",
    description: """
The NASA WB-57 is a high-altitude, mid-wing, long-range research aircraft operated by the Johnson Space Center (JSC) in Houston, Texas. Based at Ellington Field, three fully operational WB-57 aircraft have been providing invaluable support for scientific missions since the early 1970s. These aircraft remain a cornerstone of NASA’s research capabilities, offering professional, reliable, and mission-oriented services designed to meet diverse scientific objectives.

Capable of flying at altitudes exceeding 60,000 feet, the WB-57 operates for extended periods in environments where few aircraft can venture. It features tandem seating for two crew members: a pilot in the forward station with all essential flight controls, and a sensor equipment operator (SEO) in the rear station managing payloads and navigation. The WB-57 can carry up to 8,800 pounds of scientific payload and operates for approximately 6.5 hours, with a range of 2,500 nautical miles.

The aircraft is equipped with advanced power systems, including 110V/60Hz AC, 110V/400Hz AC, and 28 VDC, to support a wide variety of scientific instruments. With its ability to integrate multiple payloads throughout its airframe, the WB-57 offers unparalleled flexibility for research missions. Its high-altitude capabilities make it ideal for atmospheric studies, remote sensing, and technology testing.

The WB-57 is a subsidized resource under the Airborne Science Program, with partial funding provided to support its annual fixed operating costs. Researchers and mission planners can leverage the aircraft’s exceptional capabilities to conduct cutting-edge science in Earth’s upper atmosphere and beyond.
""",
    topSpeed: 500,
    modelPathName: "WB57",
    emitter: .none,
    sound: .largePlaneNoise,
    animationType: .large_slow_plane,
    needToPurchase: true
)














// ----------------------------------------------------------------------------------------------------------------------------

// (version 1.0)

// (1.1) added the apache helicopter, bug fixes

// (version 1.2)
//  added (hydra, B_52, HO_220, globalHawk)
//let allAircrafts = [mustang, su27, spitfire, apache ,me_109, Sukhoi, F35_Lightning2, mig_35, Eurofighter_Typhoon, F_22_Raptor, starfighter, ac130, mig17, Hind, b1Lancer, UH_60, tomcat, warthog, stealthBomber, blackBird, f_15, chengdu, mig23, Tu28, Yak_28, DassaultRafale, A6M, YE_8, F_117, F16, SU25, SU15, hydra, mig31, Bayraktar_TB2, fi56, Etrich_Taube, TU160, xb70, Osprey, B_52, HO_220, globalHawk]



// (version 1.5)
/*
 
 - fixed issue where the slow setting wouldn't slow down the show
 */
//let allAircrafts = [mustang, su27, spitfire, apache ,me_109, Sukhoi, F35_Lightning2, mig_35, Eurofighter_Typhoon, F_22_Raptor, starfighter, ac130, mig17, Hind, b1Lancer, UH_60, tomcat, warthog, stealthBomber, blackBird, f_15, chengdu, mig23, Tu28, Yak_28, DassaultRafale, A6M, YE_8, F_117, F16, SU25, SU15, hydra, mig31, Bayraktar_TB2, fi56, Etrich_Taube, TU160, xb70, Osprey, B_52, HO_220, globalHawk]




// (version 2.0) all planes (added mirage4000, F111, JAS 39 Gripen) sound balacing
//let allAircrafts = [mustang, su27, spitfire, apache ,me_109, Sukhoi, F35_Lightning2, mig_35, Eurofighter_Typhoon, F_22_Raptor, starfighter, ac130, mig17, Hind, b1Lancer, UH_60, tomcat, warthog, stealthBomber, blackBird, f_15, chengdu, mig23, Tu28, Yak_28, DassaultRafale, F111, A6M, YE_8, F_117, F16, SU25, SU15, hydra, mig31, Bayraktar_TB2, fi56, Etrich_Taube, TU160, xb70, Osprey, B_52, HO_220, globalHawk, mirage4000, gripen]



// (version 2.5) added SU57,y20, j6
//let allAircrafts = [mustang, su27, spitfire, apache ,me_109, Sukhoi, F35_Lightning2, mig_35, Eurofighter_Typhoon, F_22_Raptor, starfighter, ac130, mig17, Hind, b1Lancer, UH_60, tomcat, warthog, stealthBomber, blackBird, f_15, chengdu, mig23, Tu28, Yak_28, DassaultRafale, F111, A6M, YE_8, F_117, F16, SU25, SU15, hydra, mig31, Bayraktar_TB2, fi56, Etrich_Taube, TU160, xb70, Osprey, B_52, HO_220, globalHawk, mirage4000, gripen, SU57, Y20, J6]


// (version 3.0) added c20a, DC8, ER2, G5, P3, SIERRA, OTTER, WB57, bug fixes
let allAircrafts = [mustang, su27, spitfire, apache ,me_109, Sukhoi, F35_Lightning2, mig_35, Eurofighter_Typhoon, F_22_Raptor, starfighter, ac130, mig17, Hind, b1Lancer, UH_60, tomcat, warthog, stealthBomber, blackBird, f_15, chengdu, mig23, Tu28, Yak_28, DassaultRafale, F111, A6M, YE_8, F_117, F16, SU25, SU15, hydra, mig31, Bayraktar_TB2, fi56, Etrich_Taube, TU160, xb70, Osprey, B_52, HO_220, globalHawk, mirage4000, gripen, SU57, Y20, J6, C20A, DC8, ER2, G5, P3, SIERRA, OTTER, WB57]



// excluded aircrafts because models suck :: phantomF4, F5F









