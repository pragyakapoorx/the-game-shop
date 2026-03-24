import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game.dart';

final gamesProvider = Provider<List<Game>>((ref) {
  return _gamesData;
});

final gameByIdProvider = Provider.family<Game?, int>((ref, id) {
  final games = ref.watch(gamesProvider);
  try {
    return games.firstWhere((g) => g.id == id);
  } catch (e) {
    return null;
  }
});

const List<Game> _gamesData = [
  Game(
      id: 1, name: "Baldur's Gate 3", genre: "RPG", rating: "4.9", price: 59.99, originalPrice: null,
      badge: "hot", emoji: "🎲", bgGradient: "linear-gradient(135deg,#0d0a1e,#1a1040)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg",
      developer: "Larian Studios", publisher: "Larian Studios", released: "August 3, 2023",
      platforms: ["PC", "PS5", "Xbox Series X", "Mac"],
      size: "150 GB",
      desc: "Gather your party and return to the Forgotten Realms in a tale of fellowship and betrayal, sacrifice and survival, and the lure of absolute power. Mysterious abilities are awakening inside you, drawn from a Mind Flayer parasite planted in your brain. Resist, and turn darkness against itself. Or embrace corruption, and become ultimate evil. From the creators of Divinity: Original Sin 2 comes a next-generation RPG.",
      tags: ["Turn-Based", "D&D", "Multiplayer", "Open World", "Story Rich", "Co-op", "Fantasy", "RPG"],
      trailerYT: "1T22wNvoNiU",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1086940/ss_b63cfde456e5a81dd52e0e39706e5d12bdabcf2b.600x338.jpg", label: "Character Creation", emoji: "🎭"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1086940/ss_0aafc830c2aa2bdb1bcd7c8a9dcaec7d5df32c3a.600x338.jpg", label: "Exploration", emoji: "🗺️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1086940/ss_d7c3e5e8a8b3b1f2a3a4a5a6a7a8a9b0b1b2b3b4.600x338.jpg", label: "Combat", emoji: "⚔️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1086940/ss_e8d3c5e7a7b3b1f2a3a4a5a6a7a8a9b0b1b2b3c4.600x338.jpg", label: "Cinematics", emoji: "🎬"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel i5-4690 / AMD FX 8350", gpu: "NVIDIA GTX 970 / RX 480 (4GB+ VRAM)", ram: "8 GB RAM", storage: "150 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel i7 8700K / AMD r5 3600", gpu: "NVIDIA RTX 2060 Super / RX 5700 XT (8GB+)", ram: "16 GB RAM", storage: "150 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 2, name: "Hogwarts Legacy", genre: "RPG", rating: "4.5", price: 49.99, originalPrice: 59.99,
      badge: "sale", emoji: "⚡", bgGradient: "linear-gradient(135deg,#1a1200,#2a2000)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/990080/header.jpg",
      developer: "Avalanche Software", publisher: "Warner Bros. Games", released: "February 10, 2023",
      platforms: ["PC", "PS5", "PS4", "Xbox Series X", "Xbox One", "Switch"],
      size: "85 GB",
      desc: "Hogwarts Legacy is an immersive, open-world action RPG set in the world first introduced in the Harry Potter books. Experience Hogwarts in the 1800s. Your character is a student who holds the key to an ancient secret that threatens to tear the wizarding world apart. Discover the feeling of living at Hogwarts as you make allies, battle Dark wizards, and ultimately decide the fate of the wizarding world.",
      tags: ["Harry Potter", "Open World", "Magic", "Action RPG", "Single Player", "Fantasy", "Exploration"],
      trailerYT: "1O6Qstncpnc",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/990080/ss_b4a53e6d4a7b3b1f2a3a4a5a6a7a8a9b0b1b2b3.600x338.jpg", label: "Hogwarts Castle", emoji: "🏰"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/990080/ss_c4b53e6d4a7b3b1f2a3a4a5a6a7a8a9b0b1b2c3.600x338.jpg", label: "Spell Combat", emoji: "✨"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/990080/ss_d4c53e6d4a7b3b1f2a3a4a5a6a7a8a9b0b1b3d4.600x338.jpg", label: "Open World", emoji: "🌄"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/990080/ss_e4d53e6d4a7b3b1f2a3a4a5a6a7a8a9b0b1b4e5.600x338.jpg", label: "Creatures", emoji: "🦄"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5-6600 / AMD Ryzen 5 1400", gpu: "NVIDIA GTX 960 4GB / AMD RX 470 4GB", ram: "16 GB RAM", storage: "85 GB SSD"),
        rec: RequirementSpecs(os: "Windows 11 64-bit", cpu: "Intel Core i7-8700 / AMD Ryzen 5 3600", gpu: "NVIDIA GTX 1080 Ti / AMD RX 5700 XT", ram: "16 GB RAM", storage: "85 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 3, name: "Phasmophobia", genre: "Horror", rating: "4.7", price: 13.99, originalPrice: null,
      badge: "new", emoji: "👻", bgGradient: "linear-gradient(135deg,#0a0e14,#0e1620)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/739630/header.jpg",
      developer: "Kinetic Games", publisher: "Kinetic Games", released: "September 18, 2020",
      platforms: ["PC", "VR"],
      size: "15 GB",
      desc: "Phasmophobia is a 4-player online co-op psychological horror game. You and your team of paranormal investigators will enter haunted locations filled with paranormal activity and try to gather as much evidence as you can. Use your ghost-hunting equipment to find and record evidence to sell back to a ghost removal team. But beware — the ghosts are intelligent, responsive, and terrifying.",
      tags: ["Co-op", "Multiplayer", "Ghosts", "VR", "Psychological Horror", "Investigation", "Early Access"],
      trailerYT: "adFNARIHlOs",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/739630/ss_1f6e2d7f8a9b3b1f2a3a4a5a6a7a8a9b0b1b2a3.600x338.jpg", label: "Ghost Hunt", emoji: "🔦"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/739630/ss_2g6e2d7f8a9b3b1f2a3a4a5a6a7a8a9b0b1b3b4.600x338.jpg", label: "Equipment", emoji: "📻"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/739630/ss_3h6e2d7f8a9b3b1f2a3a4a5a6a7a8a9b0b1b4c5.600x338.jpg", label: "Haunted House", emoji: "🏚️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/739630/ss_4i6e2d7f8a9b3b1f2a3a4a5a6a7a8a9b0b1b5d6.600x338.jpg", label: "Spirit Board", emoji: "🪄"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5-4590 / AMD FX 8350", gpu: "NVIDIA GTX 970 / AMD Radeon R9 290", ram: "8 GB RAM", storage: "15 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i7-6700 / AMD Ryzen 5 1600", gpu: "NVIDIA GTX 1070 / AMD RX 480", ram: "8 GB RAM", storage: "15 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 4, name: "Lethal Company", genre: "Horror", rating: "4.8", price: 9.99, originalPrice: null,
      badge: "hot", emoji: "🌕", bgGradient: "linear-gradient(135deg,#080a0e,#101420)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1966720/header.jpg",
      developer: "Zeekerss", publisher: "Zeekerss", released: "October 23, 2023",
      platforms: ["PC"],
      size: "1 GB",
      desc: "A co-op horror game about collecting scrap for the Company. You are a contracted worker for the Company — collect enough valuable scrap from abandoned, industrialized moons to meet the profit quota. Survive the creatures. Bring home the loot. Work together or die together. The Company doesn't care either way. Stylized, brutally funny, terrifying co-op horror.",
      tags: ["Co-op", "Multiplayer", "Horror", "Indie", "Funny", "Dark Humor", "Monster", "Survival"],
      trailerYT: "Su6OsTb1w9Q",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1966720/ss_1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b.600x338.jpg", label: "Abandoned Factory", emoji: "🏭"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1966720/ss_2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a1b2.600x338.jpg", label: "The Company Moon", emoji: "🌑"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1966720/ss_3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a2c3d4.600x338.jpg", label: "Collecting Scrap", emoji: "🔧"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1966720/ss_4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a3d4e5f6.600x338.jpg", label: "Creature Encounter", emoji: "👁️"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10", cpu: "Intel Core i5", gpu: "NVIDIA GTX 580 / AMD HD 7870", ram: "4 GB RAM", storage: "1 GB"),
        rec: RequirementSpecs(os: "Windows 10", cpu: "Intel Core i7", gpu: "NVIDIA GTX 1060 / AMD RX 580", ram: "8 GB RAM", storage: "1 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 5, name: "Minecraft", genre: "Sandbox", rating: "4.9", price: 29.99, originalPrice: null,
      badge: null, emoji: "⛏️", bgGradient: "linear-gradient(135deg,#1a3a1a,#2a5a2a)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1672970/header.jpg",
      developer: "Mojang Studios", publisher: "Mojang Studios / Microsoft", released: "November 18, 2011",
      platforms: ["PC", "PS5", "PS4", "Xbox", "Switch", "Mobile"],
      size: "30 GB",
      desc: "Minecraft is a sandbox game about placing blocks and going on adventures. Explore randomly generated worlds and build amazing things from the simplest of homes to the grandest of castles. Play in creative mode with unlimited resources or mine deep into the world in survival mode, crafting weapons and armour to fend off dangerous mobs. One of the best-selling video games of all time.",
      tags: ["Sandbox", "Survival", "Creative", "Multiplayer", "Open World", "Building", "Crafting", "Family-Friendly"],
      trailerYT: "MmB9b5njVbA",
      screenshots: [
        GameScreenshot(url: "https://www.minecraft.net/content/dam/games/minecraft/screenshots/screenshot-caves-and-cliffs.jpg", label: "Caves & Cliffs", emoji: "⛰️"),
        GameScreenshot(url: "https://www.minecraft.net/content/dam/games/minecraft/screenshots/screenshot-nether.jpg", label: "The Nether", emoji: "🔥"),
        GameScreenshot(url: "https://www.minecraft.net/content/dam/games/minecraft/screenshots/screenshot-village.jpg", label: "Village", emoji: "🏘️"),
        GameScreenshot(url: "https://www.minecraft.net/content/dam/games/minecraft/screenshots/screenshot-ocean.jpg", label: "Ocean Monument", emoji: "🌊"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10/11", cpu: "Intel Core i3-3210 / AMD A8-7600 APU", gpu: "Intel HD 4000 / AMD Radeon R5", ram: "4 GB RAM", storage: "4 GB"),
        rec: RequirementSpecs(os: "Windows 10/11", cpu: "Intel Core i5-4690 / AMD A10-7800 APU", gpu: "NVIDIA GTX 700 Series / AMD Radeon Rx 200", ram: "8 GB RAM", storage: "8 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 6, name: "Silent Hill 2 (Remake)", genre: "Horror", rating: "4.8", price: 59.99, originalPrice: null,
      badge: "new", emoji: "🌫️", bgGradient: "linear-gradient(135deg,#0e0a08,#201410)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/2124490/header.jpg",
      developer: "Bloober Team", publisher: "Konami", released: "October 8, 2024",
      platforms: ["PC", "PS5"],
      size: "50 GB",
      desc: "Return to Silent Hill 2 — the legendary survival horror game, completely remade from the ground up. James Sunderland receives a letter from his deceased wife Mary, asking him to meet her in Silent Hill — a town they once visited together. Journey through fog-choked streets and grotesque otherworldly dimensions in this deeply psychological horror masterpiece, rebuilt with modern visuals and gameplay.",
      tags: ["Survival Horror", "Psychological", "Atmospheric", "Remake", "Third-Person", "Dark", "Investigation"],
      trailerYT: "pyC_qiW_4ZY",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2124490/ss_a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0.600x338.jpg", label: "Foggy Streets", emoji: "🌁"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2124490/ss_b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9c1d2.600x338.jpg", label: "Otherworld", emoji: "🩸"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2124490/ss_c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9d2e3f4.600x338.jpg", label: "Pyramid Head", emoji: "⚙️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2124490/ss_d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9e3f4a5b6.600x338.jpg", label: "Hospital", emoji: "🏥"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "AMD Ryzen 5 2600X / Intel Core i7-8700", gpu: "AMD Radeon RX 5700 / NVIDIA GTX 1080", ram: "12 GB RAM", storage: "50 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10/11 64-bit", cpu: "AMD Ryzen 7 3700X / Intel Core i7-8700K", gpu: "AMD RX 6800 XT / NVIDIA RTX 2080 Ti", ram: "12 GB RAM", storage: "50 GB NVMe SSD"),
      ), isFree: false
  ),
  Game(
      id: 7, name: "Pillars of Eternity II", genre: "RPG", rating: "4.6", price: 19.99, originalPrice: 39.99,
      badge: "sale", emoji: "⚓", bgGradient: "linear-gradient(135deg,#0a1020,#102040)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/560130/header.jpg",
      developer: "Obsidian Entertainment", publisher: "Versus Evil", released: "May 8, 2018",
      platforms: ["PC", "PS4", "Xbox One", "Switch"],
      size: "45 GB",
      desc: "Deadfire builds on the foundation of classic isometric RPGs. You awaken after being killed by a god and must chase them across the seas of the Deadfire Archipelago. Sail your ship, explore tropical islands, recruit diverse companions, and shape the fate of the archipelago's many factions. Features deep narrative, tactical real-time-with-pause combat, and extraordinary world-building.",
      tags: ["CRPG", "Isometric", "Turn-Based", "Story Rich", "Fantasy", "Party-Based", "Tactical"],
      trailerYT: "IaO7oboQGJg",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/560130/ss_a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6.600x338.jpg", label: "Ship Combat", emoji: "⛵"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/560130/ss_b2c3d4e5f6a7b8c9d0e1f2a3b4c5d7e8.600x338.jpg", label: "Island Exploration", emoji: "🏝️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/560130/ss_c3d4e5f6a7b8c9d0e1f2a3b4c5d6e8f9.600x338.jpg", label: "Party Combat", emoji: "⚔️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/560130/ss_d4e5f6a7b8c9d0e1f2a3b4c5d6e7f0a1.600x338.jpg", label: "City of Neketaka", emoji: "🏛️"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows Vista 64-bit SP2", cpu: "Intel Core i3-2100T / AMD Phenom II X3 B73", gpu: "NVIDIA GeForce 560 / ATI Radeon HD 7800", ram: "4 GB RAM", storage: "45 GB"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5-2500K / AMD Phenom II X6 1100T", gpu: "NVIDIA GeForce GTX 770 2GB / AMD Radeon HD 7970", ram: "16 GB RAM", storage: "45 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 8, name: "Death Stranding", genre: "Action", rating: "4.4", price: 29.99, originalPrice: 39.99,
      badge: "sale", emoji: "🌧️", bgGradient: "linear-gradient(135deg,#0a0e14,#141c28)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1190460/header.jpg",
      developer: "Kojima Productions", publisher: "505 Games", released: "July 14, 2020",
      platforms: ["PC", "PS4", "PS5"],
      size: "80 GB",
      desc: "From legendary creator Hideo Kojima comes a genre-defying experience. In Death Stranding, you play as Sam Porter Bridges — a delivery man tasked with reconnecting a fractured society after a mysterious cataclysmic event. Cross rugged terrain, battle invisible ghosts, and forge links between isolated communities in a profoundly unique journey through post-apocalyptic America.",
      tags: ["Open World", "Walking Simulator", "Action", "Multiplayer", "Strand Game", "Kojima", "Atmospheric", "Post-Apocalyptic"],
      trailerYT: "tCI396HyhbQ",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1190460/ss_a1b2c3d4e5f6a7b8c9d0.600x338.jpg", label: "Vast Landscape", emoji: "🏔️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1190460/ss_b2c3d4e5f6a7b8c9d1e2.600x338.jpg", label: "BT Encounter", emoji: "👁️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1190460/ss_c3d4e5f6a7b8c9d2e3f4.600x338.jpg", label: "Delivery Run", emoji: "📦"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1190460/ss_d4e5f6a7b8c9d3e4f5a6.600x338.jpg", label: "Sam Bridges", emoji: "🚶"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10", cpu: "Intel Core i5-8600 / AMD Ryzen 5 2600", gpu: "NVIDIA GTX 1060 6GB / AMD RX 590", ram: "8 GB RAM", storage: "80 GB HDD"),
        rec: RequirementSpecs(os: "Windows 10", cpu: "Intel Core i7-8700 / AMD Ryzen 5 3600", gpu: "NVIDIA GTX 1080 / AMD RX 5700", ram: "8 GB RAM", storage: "80 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 9, name: "Disco Elysium", genre: "RPG", rating: "4.9", price: 29.99, originalPrice: 39.99,
      badge: "sale", emoji: "🎙️", bgGradient: "linear-gradient(135deg,#1a1208,#2a1c0c)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/632470/header.jpg",
      developer: "ZA/UM", publisher: "ZA/UM", released: "October 15, 2019",
      platforms: ["PC", "PS4", "PS5", "Xbox"],
      size: "17 GB",
      desc: "Disco Elysium is a groundbreaking open world role playing game. You're a detective with a unique skill system at your disposal and a whole city block to carve your path across. Interrogate unforgettable characters, crack murder cases, or lose yourself in a world of hard-boiled noir. Be a hero, or an absolute disaster of a human being. The richest narrative RPG ever made.",
      tags: ["Narrative", "Isometric", "Detective", "No Combat", "Dark Humor", "Politics", "Choices Matter", "Award-Winning"],
      trailerYT: "ZHefk0w6F7c",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/632470/ss_a1b2c3d4e5.600x338.jpg", label: "Revachol Streets", emoji: "🌃"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/632470/ss_b2c3d4e5f6.600x338.jpg", label: "Skill Checks", emoji: "🎲"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/632470/ss_c3d4e5f6a7.600x338.jpg", label: "Investigation", emoji: "🔍"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/632470/ss_d4e5f6a7b8.600x338.jpg", label: "Character Dialogue", emoji: "💬"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 7", cpu: "Intel Core2 Duo E8400 / AMD Phenom II X2 550", gpu: "NVIDIA GeForce 9800GT / AMD HD 5770 (1GB VRAM)", ram: "8 GB RAM", storage: "17 GB"),
        rec: RequirementSpecs(os: "Windows 10", cpu: "Intel Core i5-4670K / AMD Ryzen 5 2600X", gpu: "NVIDIA GTX 970 / AMD RX 470 (4GB VRAM)", ram: "8 GB RAM", storage: "17 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 10, name: "Cyberpunk 2077", genre: "RPG", rating: "4.6", price: 39.99, originalPrice: 59.99,
      badge: "sale", emoji: "🌆", bgGradient: "linear-gradient(135deg,#0a0010,#1a0028)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg",
      developer: "CD Projekt Red", publisher: "CD Projekt", released: "December 10, 2020",
      platforms: ["PC", "PS5", "PS4", "Xbox Series X", "Xbox One"],
      size: "70 GB",
      desc: "Cyberpunk 2077 is an open-world, action-adventure RPG set in the megalopolis of Night City. Play as a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality. Featuring Johnny Silverhand (Keanu Reeves), an all-new story expansion Phantom Liberty, and a fully revamped game since launch. Night City has never looked better.",
      tags: ["Open World", "Cyberpunk", "Action RPG", "Story Rich", "First-Person", "Mature", "Sci-Fi", "Keanu Reeves"],
      trailerYT: "8X2kIfS6fb8",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1091500/ss_b529b0af459630673fb596f3de1f8b535fc7498b.600x338.jpg", label: "Night City", emoji: "🌃"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1091500/ss_1de18b17fcd5c74e12a7e1c8b7f88ca8ee9a8d11.600x338.jpg", label: "V — Protagonist", emoji: "👤"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1091500/ss_7b01b44a2bc4bb8d9cb09f94d7b0c3cd50a5e3c1.600x338.jpg", label: "Combat", emoji: "⚡"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1091500/ss_2e0afb0dbc48bfd5a1db62c2c23e65f64a6f4e2a.600x338.jpg", label: "The Badlands", emoji: "🏜️"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i7-6700K / AMD Ryzen 5 1600", gpu: "NVIDIA GTX 1060 6GB / AMD RX 580 8GB", ram: "12 GB RAM", storage: "70 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10/11 64-bit", cpu: "Intel Core i7-8700K / AMD Ryzen 5 3600", gpu: "NVIDIA RTX 2060 Super / AMD RX 5700 XT", ram: "16 GB RAM", storage: "70 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 11, name: "The Legend of Zelda: Breath of the Wild", genre: "Adventure", rating: "4.9", price: 59.99, originalPrice: null,
      badge: null, emoji: "🌿", bgGradient: "linear-gradient(135deg,#0a1a0a,#142814)",
      cover: "https://automationpanda.com/wp-content/uploads/2018/06/botw-share_icon.jpg",
      developer: "Nintendo EPD", publisher: "Nintendo", released: "March 3, 2017",
      platforms: ["Switch", "Wii U"],
      size: "14 GB",
      desc: "Step into a world of discovery, exploration, and adventure in The Legend of Zelda: Breath of the Wild, a boundary-breaking new game in the acclaimed series. Travel across vast fields, through forests, and to mountain peaks as you discover what has become of the kingdom of Hyrule in this stunning Open-Air Adventure. One of the greatest games ever made.",
      tags: ["Open World", "Nintendo", "Adventure", "Exploration", "Puzzle", "Action", "Switch Exclusive", "GOTY"],
      trailerYT: "1rPxiXXxftE",
      screenshots: [
        GameScreenshot(url: "https://assets.nintendo.com/image/upload/c_fill,w_800/q_auto:best/f_auto/dpr_2.0/ncom/software/switch/70010000000025/screenshot-01", label: "Hyrule Field", emoji: "🏞️"),
        GameScreenshot(url: "https://assets.nintendo.com/image/upload/c_fill,w_800/q_auto:best/f_auto/dpr_2.0/ncom/software/switch/70010000000025/screenshot-02", label: "Combat", emoji: "⚔️"),
        GameScreenshot(url: "https://assets.nintendo.com/image/upload/c_fill,w_800/q_auto:best/f_auto/dpr_2.0/ncom/software/switch/70010000000025/screenshot-03", label: "Climbing", emoji: "🧗"),
        GameScreenshot(url: "https://assets.nintendo.com/image/upload/c_fill,w_800/q_auto:best/f_auto/dpr_2.0/ncom/software/switch/70010000000025/screenshot-04", label: "Shrine", emoji: "🏯"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Nintendo Switch", cpu: "Custom ARM Cortex-A57", gpu: "NVIDIA Tegra X1", ram: "4 GB RAM", storage: "14 GB"),
        rec: RequirementSpecs(os: "Nintendo Switch (OLED)", cpu: "Custom ARM Cortex-A57", gpu: "NVIDIA Tegra X1+", ram: "4 GB RAM", storage: "14 GB"),
      ), isFree: false
  ),
  Game(
      id: 12, name: "Resident Evil 4 (Remake)", genre: "Horror", rating: "4.8", price: 49.99, originalPrice: 59.99,
      badge: "sale", emoji: "🧟", bgGradient: "linear-gradient(135deg,#0e1008,#181808)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg",
      developer: "Capcom", publisher: "Capcom", released: "March 24, 2023",
      platforms: ["PC", "PS5", "PS4", "Xbox Series X"],
      size: "67 GB",
      desc: "Survival is just the beginning. A complete reimagining of Resident Evil 4 — rebuilt from the ground up using the RE Engine. Leon S. Kennedy is dispatched on a mission to rescue the U.S. President's daughter who has been kidnapped by a sinister cult in rural Europe. Leon must confront hordes of villagers and horrifying mutated creatures while uncovering the cult's disturbing secrets.",
      tags: ["Survival Horror", "Action", "Third-Person", "Remake", "Shooting", "Classic", "Single Player"],
      trailerYT: "eR1jueJOXPo",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2050650/ss_a1b2c3d4e5f6a7b8c9d0e1f2.600x338.jpg", label: "Village", emoji: "🏡"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2050650/ss_b2c3d4e5f6a7b8c9d0e1f2a3.600x338.jpg", label: "Leon Kennedy", emoji: "🔫"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2050650/ss_c3d4e5f6a7b8c9d0e1f2a3b4.600x338.jpg", label: "El Gigante", emoji: "👹"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2050650/ss_d4e5f6a7b8c9d0e1f2a3b4c5.600x338.jpg", label: "The Castle", emoji: "🏰"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "AMD Ryzen 3 1200 / Intel Core i5-7500", gpu: "AMD Radeon RX 5500 XT / NVIDIA GTX 1070", ram: "8 GB RAM", storage: "67 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10/11 64-bit", cpu: "AMD Ryzen 5 3600 / Intel Core i7-8700", gpu: "AMD Radeon RX 6700 / NVIDIA RTX 2070", ram: "16 GB RAM", storage: "67 GB NVMe SSD"),
      ), isFree: false
  ),
  Game(
      id: 13, name: "GTA V (Grand Theft Auto V)", genre: "Action", rating: "4.7", price: 19.99, originalPrice: 29.99,
      badge: "sale", emoji: "🚗", bgGradient: "linear-gradient(135deg,#0a0e1a,#102030)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/271590/header.jpg",
      developer: "Rockstar North", publisher: "Rockstar Games", released: "September 17, 2013",
      platforms: ["PC", "PS5", "PS4", "Xbox Series X", "Xbox One"],
      size: "100 GB",
      desc: "Grand Theft Auto V and GTA Online — now enhanced for a new generation. Experience Rockstar Games' epic open world set in the fictional state of San Andreas. Switch between three protagonists — Michael, Trevor, and Franklin — as they pull off heists across Los Santos. Includes the ever-expanding GTA Online with hundreds of hours of additional content.",
      tags: ["Open World", "Crime", "Multiplayer", "Heist", "Online", "Action", "Mature", "Rockstar"],
      trailerYT: "QkkoHAzjnUs",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/271590/ss_908485840bb61e5ee9a855beb82de0e6c28941d3.600x338.jpg", label: "Los Santos", emoji: "🌆"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/271590/ss_1f9e2d3f8a9b3b1f2a3a4a5a6a7a8a9b0b1b2b3.600x338.jpg", label: "Heist", emoji: "💰"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/271590/ss_2g9e2d3f8a9b3b1f2a3a4a5a6a7a8a9b0b1b3b4.600x338.jpg", label: "GTA Online", emoji: "🤝"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/271590/ss_3h9e2d3f8a9b3b1f2a3a4a5a6a7a8a9b0b1b4c5.600x338.jpg", label: "Trevor", emoji: "😈"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core 2 Quad CPU Q6600 / AMD Phenom 9850", gpu: "NVIDIA 9800 GT 1GB / AMD HD 4870 1GB", ram: "4 GB RAM", storage: "100 GB HDD"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5 3470 / AMD X8 FX-8350", gpu: "NVIDIA GTX 660 2GB / AMD HD 7870 2GB", ram: "8 GB RAM", storage: "100 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 14, name: "Divinity: Original Sin 2", genre: "RPG", rating: "4.9", price: 39.99, originalPrice: 44.99,
      badge: null, emoji: "🐉", bgGradient: "linear-gradient(135deg,#1a0808,#300c0c)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/435150/header.jpg",
      developer: "Larian Studios", publisher: "Larian Studios", released: "September 14, 2017",
      platforms: ["PC", "PS4", "Xbox One", "Switch", "Mac"],
      size: "50 GB",
      desc: "The critically acclaimed RPG that revolutionized a genre. Choose your race and origin, or build your own character from scratch. Discover and combine skills to create your own playstyle. Challenge players in online and offline multiplayer, or take on the campaign solo with up to 4 players. Every choice matters — shape the world and its inhabitants through your decisions.",
      tags: ["Turn-Based", "Co-op", "Fantasy", "CRPG", "Story Rich", "Choices Matter", "Multiplayer", "Classic"],
      trailerYT: "vJ4SVSm1ARQ",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/435150/ss_a1b2c3.600x338.jpg", label: "Fort Joy", emoji: "🏰"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/435150/ss_b2c3d4.600x338.jpg", label: "Tactical Combat", emoji: "⚔️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/435150/ss_c3d4e5.600x338.jpg", label: "The Source", emoji: "✨"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/435150/ss_d4e5f6.600x338.jpg", label: "Co-op Party", emoji: "👥"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 7 SP1 64-bit", cpu: "Intel Core i5 2400 / AMD A10", gpu: "NVIDIA GTX 550 Ti / AMD Radeon HD 6XXX (1GB VRAM)", ram: "4 GB RAM", storage: "50 GB"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i7 / AMD Ryzen 5", gpu: "NVIDIA GTX 770 / AMD R9 280X (2GB VRAM)", ram: "8 GB RAM", storage: "50 GB SSD"),
      ), isFree: false
  ),
  Game(
      id: 15, name: "The Sims 4", genre: "Simulation", rating: "3.8", price: 0.0, originalPrice: 39.99,
      badge: "free", emoji: "🏠", bgGradient: "linear-gradient(135deg,#0e1a2e,#182a40)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1222670/header.jpg",
      developer: "Maxis", publisher: "Electronic Arts", released: "September 2, 2014",
      platforms: ["PC", "PS4", "PS5", "Xbox One", "Xbox Series X", "Mac"],
      size: "50 GB",
      desc: "The Sims 4 is the life simulation game that gives you the power to create and control people. Create new Sims with unique looks, personalities, and aspirations. Build and design beautiful homes. Explore vibrant neighborhoods full of other Sims. Pursue careers, improve skills, and live your Sim's story — or let them spiral into beautiful chaos. Free-to-play since October 2022.",
      tags: ["Life Simulation", "Creative", "Casual", "Building", "Free-to-Play", "Family-Friendly", "Character Creator", "EA"],
      trailerYT: "0D5bRyZV_Dw",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1222670/ss_a1b2c3d4e5.600x338.jpg", label: "Build Mode", emoji: "🔨"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1222670/ss_b2c3d4e5f6.600x338.jpg", label: "Create a Sim", emoji: "👤"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1222670/ss_c3d4e5f6a7.600x338.jpg", label: "Neighborhood", emoji: "🏘️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1222670/ss_d4e5f6a7b8.600x338.jpg", label: "Skills", emoji: "🎨"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5-2300 / AMD Athlon X4 870K", gpu: "NVIDIA GTX 650 / AMD Radeon HD 5670 / Intel HD 4000 (1GB VRAM)", ram: "4 GB RAM", storage: "50 GB"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel Core i5-3570 / AMD Ryzen 3", gpu: "NVIDIA GTX 650 Ti / AMD HD 7870 (2GB VRAM)", ram: "8 GB RAM", storage: "50 GB SSD"),
      ), isFree: true
  ),
  Game(
      id: 16, name: "Metal Gear Solid V: The Phantom Pain", genre: "Action", rating: "4.8", price: 19.99, originalPrice: null,
      badge: null, emoji: "🐍", bgGradient: "linear-gradient(135deg,#0a0e08,#141a10)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/287700/header.jpg",
      developer: "Kojima Productions", publisher: "Konami", released: "September 1, 2015",
      platforms: ["PC", "PS4", "PS3", "Xbox One", "Xbox 360"],
      size: "28 GB",
      desc: "Metal Gear Solid V: The Phantom Pain is an open world stealth action game — the final chapter in Hideo Kojima's legendary Metal Gear series. Crawl through enemy bases undetected, extract soldiers with balloons, and build your own private military force. One of the finest open-world stealth games ever made, set across Afghanistan and Africa with a sprawling base-building meta game.",
      tags: ["Stealth", "Open World", "Action", "Kojima", "Military", "Single Player", "Online", "Espionage"],
      trailerYT: "C19ap2M7DDE",
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/287700/ss_a1b2c3d4.600x338.jpg", label: "Afghanistan", emoji: "🏜️"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/287700/ss_b2c3d4e5.600x338.jpg", label: "Base Infiltration", emoji: "🔦"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/287700/ss_c3d4e5f6.600x338.jpg", label: "Fulton Extraction", emoji: "🎈"),
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/287700/ss_d4e5f6a7.600x338.jpg", label: "Mother Base", emoji: "🛥️"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 7 x64", cpu: "Intel Core i5-4460 / AMD FX-6300", gpu: "NVIDIA GTX 650 (2GB) / AMD HD 7770 (2GB)", ram: "4 GB RAM", storage: "28 GB SSD"),
        rec: RequirementSpecs(os: "Windows 8.1 x64", cpu: "Intel Core i7-4790 / AMD FX-9590", gpu: "NVIDIA GTX 760 / AMD R9 280X", ram: "8 GB RAM", storage: "28 GB SSD"),
      ), isFree: false
  ),
];