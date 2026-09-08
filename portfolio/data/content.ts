export interface ProjectLink {
  label: string;
  url: string;
}

export interface ProjectStatistic {
  label: string;
  value: string;
}

export interface Project {
  id: string;
  slug: string;
  title: string;
  company: string | null;
  client: string | null;
  role: string;
  employmentType: string;
  duration: string;
  startDate: string;
  endDate: string | null;
  currentlyWorking: boolean;
  shortDescription: string;
  fullDescription: string;
  problemStatement: string;
  solution: string;
  responsibilities: string[];
  keyFeatures: string[];
  technologies: string[];
  platforms: string[];
  screenshots: string[];
  thumbnail: string | null;
  coverImage: string | null;
  githubUrl: string | null;
  liveUrl: string | null;
  playStoreUrl: string | null;
  appStoreUrl: string | null;
  featured: boolean;
  privateProject: boolean;
  canShowScreenshots: boolean;
  canShowCompanyName: boolean;
  links: ProjectLink[];
  statistics: ProjectStatistic[];
}

export const profile = {
  name: "Mughees Ahmad",
  title: "Senior Full Stack Developer",
  specialization: ["Flutter", "React Native", "ASP.NET Core", "Angular"],
  tagline:
    "I build and ship production mobile and enterprise web apps — live on the App Store and Google Play.",
  experience: "3+ Years",
  company: "HBit Technology LLC",
  location: "Multan, Pakistan",
  availability: "Available for select remote roles · Worldwide",
  relocation: "Open to relocation for the right opportunity and compensation.",
  email: "mughees.ahmad@example.com",
  phone: "+92 300 0000000",
  github: "https://github.com/mugheesahmad",
  linkedin: "https://linkedin.com/in/mugheesahmad",
  summary:
    "Senior Full Stack Developer with 3+ years building production mobile and enterprise web applications. I own features end to end — from Flutter and React Native clients to ASP.NET Core Web APIs and Angular dashboards — and I ship to real users on iOS, Android and the web.",
};

export const stats = [
  { value: "3+", label: "Years experience" },
  { value: "iOS · Android", label: "Published to stores" },
  { value: "Enterprise", label: "EV charging platform" },
  { value: "Full Stack", label: "Client to API to DB" },
];

export const techStack = [
  "Flutter",
  "Dart",
  "React Native",
  "Angular",
  "C#",
  "ASP.NET Core",
  "Firebase",
  "SQL Server",
  "SQLite",
  "REST APIs",
  "Google Maps",
  "Git",
];

export const skillGroups = [
  {
    category: "Mobile",
    skills: ["Flutter", "Dart", "React Native", "Android", "iOS"],
  },
  {
    category: "Frontend",
    skills: ["Angular", "TypeScript", "RxJS", "Responsive UI"],
  },
  {
    category: "Backend",
    skills: ["C#", "ASP.NET Core Web API", "REST APIs", "Auth / JWT"],
  },
  {
    category: "Database",
    skills: ["SQL Server", "SQLite", "Entity Framework", "Firestore"],
  },
  {
    category: "Cloud & Services",
    skills: ["Firebase", "Cloud Messaging", "Google Maps", "Push Notifications"],
  },
  {
    category: "Tools",
    skills: ["Git", "GitHub", "CI/CD", "Postman", "Figma"],
  },
];

export const experience = [
  {
    company: "HBit Technology LLC",
    role: "Senior Full Stack Developer",
    duration: "2023 — Present",
    current: true,
    location: "Remote · Multan, Pakistan",
    responsibilities: [
      "Lead mobile delivery for an enterprise EV charging platform across iOS and Android.",
      "Design and build ASP.NET Core Web APIs powering both mobile and Angular dashboards.",
      "Own release pipelines and store submissions for published production apps.",
    ],
    technologies: ["Flutter", "ASP.NET Core", "Angular", "SQL Server", "Firebase"],
  },
  {
    company: "HBit Technology LLC",
    role: "Full Stack Developer",
    duration: "2022 — 2023",
    current: false,
    location: "Multan, Pakistan",
    responsibilities: [
      "Built cross-platform mobile features in Flutter and React Native.",
      "Integrated Google Maps, Firebase Cloud Messaging and REST services.",
      "Collaborated on Angular admin dashboards for enterprise clients.",
    ],
    technologies: ["Flutter", "React Native", "Angular", "Google Maps", "REST APIs"],
  },
];

export const education = [
  {
    degree: "BS Computer Science",
    school: "Bahauddin Zakariya University",
    duration: "2018 — 2022",
    detail: "Focused on software engineering, data structures and mobile computing.",
  },
];

export const values = [
  {
    title: "Ship to real users",
    detail: "Production quality over demos. I measure success by apps live in the stores.",
  },
  {
    title: "Own it end to end",
    detail: "From UI to API to database — I take features across the whole stack.",
  },
  {
    title: "Clarity over cleverness",
    detail: "Readable, maintainable code that a team can move fast on.",
  },
  {
    title: "Enterprise discipline",
    detail: "Reliable releases, secure APIs, and respect for client confidentiality.",
  },
];

export const projects: Project[] = [
  {
    id: "1",
    slug: "ev-charging-platform",
    title: "EV Charging Platform",
    company: "HBit Technology LLC",
    client: null,
    role: "Lead Mobile & Backend Developer",
    employmentType: "Full-time",
    duration: "10 months",
    startDate: "2023",
    endDate: null,
    currentlyWorking: true,
    shortDescription:
      "Enterprise platform for locating, reserving and paying for EV charging across a national network.",
    fullDescription:
      "A production EV charging platform serving drivers and station operators. Drivers locate and reserve chargers, start sessions and pay in-app; operators monitor stations from an Angular dashboard. Built mobile-first with a shared ASP.NET Core Web API.",
    problemStatement:
      "Drivers had no reliable way to find available chargers, reserve them ahead, or pay without juggling multiple apps and RFID cards.",
    solution:
      "A single Flutter app backed by real-time station availability, in-app reservations and payments, and live session monitoring — with an operator dashboard for the network side.",
    responsibilities: [
      "Architected the Flutter client and shared ASP.NET Core Web API.",
      "Built real-time station availability and reservation flows.",
      "Integrated in-app payments and live charging session tracking.",
      "Shipped and maintained production releases on iOS and Android.",
    ],
    keyFeatures: [
      "Live map of charger availability",
      "Reserve-ahead and queue management",
      "In-app payments and receipts",
      "Real-time session monitoring",
    ],
    technologies: ["Flutter", "Dart", "ASP.NET Core", "SQL Server", "Google Maps", "Firebase"],
    platforms: ["Android", "iOS", "Web"],
    screenshots: [],
    thumbnail: null,
    coverImage: null,
    githubUrl: null,
    liveUrl: null,
    playStoreUrl: null,
    appStoreUrl: null,
    featured: true,
    privateProject: true,
    canShowScreenshots: false,
    canShowCompanyName: true,
    links: [],
    statistics: [
      { label: "Charging stations", value: "500+" },
      { label: "Faster onboarding", value: "40%" },
      { label: "Platforms shipped", value: "3" },
    ],
  },
  {
    id: "2",
    slug: "field-service-app",
    title: "Field Service Mobile App",
    company: "HBit Technology LLC",
    client: "Enterprise Logistics Client",
    role: "Mobile Developer",
    employmentType: "Full-time",
    duration: "6 months",
    startDate: "2023",
    endDate: "2023",
    currentlyWorking: false,
    shortDescription:
      "Cross-platform app for field technicians to manage jobs, capture proof of work and sync offline.",
    fullDescription:
      "A React Native app for field technicians handling daily job assignments, on-site checklists, photo capture and offline-first sync back to the enterprise backend.",
    problemStatement:
      "Field teams relied on paper job sheets and lost data whenever connectivity dropped on remote sites.",
    solution:
      "An offline-first mobile app that queues work locally and syncs automatically, with push-driven job dispatch and photo proof of completion.",
    responsibilities: [
      "Built offline-first data sync and conflict handling.",
      "Implemented push-driven job dispatch with Firebase Cloud Messaging.",
      "Added on-site photo capture and geotagged completion.",
    ],
    keyFeatures: [
      "Offline-first job queue",
      "Push job dispatch",
      "Photo proof of work",
      "Geotagged completion",
    ],
    technologies: ["React Native", "TypeScript", "Firebase", "REST APIs"],
    platforms: ["Android", "iOS"],
    screenshots: [
      "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=1200&h=800&fit=crop",
      "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=1200&h=800&fit=crop",
    ],
    thumbnail: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=600&fit=crop",
    coverImage: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=1600&h=900&fit=crop",
    githubUrl: null,
    liveUrl: null,
    playStoreUrl: "https://play.google.com",
    appStoreUrl: "https://apps.apple.com",
    featured: true,
    privateProject: false,
    canShowScreenshots: true,
    canShowCompanyName: true,
    links: [],
    statistics: [
      { label: "Technicians", value: "300+" },
      { label: "Less paperwork", value: "70%" },
    ],
  },
  {
    id: "3",
    slug: "operations-dashboard",
    title: "Operations Analytics Dashboard",
    company: "HBit Technology LLC",
    client: null,
    role: "Frontend Developer",
    employmentType: "Full-time",
    duration: "4 months",
    startDate: "2022",
    endDate: "2023",
    currentlyWorking: false,
    shortDescription:
      "Angular dashboard giving operators live visibility into fleet, sessions and revenue.",
    fullDescription:
      "An Angular admin dashboard consuming the same ASP.NET Core APIs as the mobile clients, surfacing operational KPIs, station health and revenue reporting.",
    problemStatement:
      "Operators had no single view of network health, active sessions or revenue trends.",
    solution:
      "A responsive Angular dashboard with live KPI cards, filterable tables and exportable reports built on a shared API layer.",
    responsibilities: [
      "Built responsive Angular views and reusable chart components.",
      "Consumed shared ASP.NET Core Web APIs with typed models.",
      "Implemented role-based access and exportable reports.",
    ],
    keyFeatures: [
      "Live KPI overview",
      "Filterable session tables",
      "Revenue reporting",
      "Role-based access",
    ],
    technologies: ["Angular", "TypeScript", "ASP.NET Core", "SQL Server"],
    platforms: ["Web"],
    screenshots: [
      "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=1200&h=800&fit=crop",
    ],
    thumbnail: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop",
    coverImage: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=1600&h=900&fit=crop",
    githubUrl: null,
    liveUrl: null,
    playStoreUrl: null,
    appStoreUrl: null,
    featured: false,
    privateProject: false,
    canShowScreenshots: true,
    canShowCompanyName: true,
    links: [],
    statistics: [
      { label: "KPIs tracked", value: "20+" },
    ],
  },
  {
    id: "4",
    slug: "logistics-tracking",
    title: "Live Logistics Tracking",
    company: "HBit Technology LLC",
    client: null,
    role: "Full Stack Developer",
    employmentType: "Full-time",
    duration: "5 months",
    startDate: "2022",
    endDate: "2022",
    currentlyWorking: false,
    shortDescription:
      "Flutter app with live Google Maps tracking and route optimization for delivery fleets.",
    fullDescription:
      "A Flutter app providing real-time vehicle tracking, route playback and ETA estimates, backed by a REST API and Google Maps integration.",
    problemStatement:
      "Dispatchers and customers had no real-time visibility into delivery location or ETAs.",
    solution:
      "Live map tracking with route history and ETA estimates, delivered through a Flutter client and a lightweight REST backend.",
    responsibilities: [
      "Integrated Google Maps live tracking and route playback.",
      "Built ETA estimation and geofencing alerts.",
      "Developed supporting REST endpoints.",
    ],
    keyFeatures: [
      "Real-time vehicle tracking",
      "Route history playback",
      "ETA estimates",
      "Geofence alerts",
    ],
    technologies: ["Flutter", "Dart", "Google Maps", "REST APIs", "SQLite"],
    platforms: ["Android", "iOS"],
    screenshots: [
      "https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=1200&h=800&fit=crop",
    ],
    thumbnail: "https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=800&h=600&fit=crop",
    coverImage: "https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=1600&h=900&fit=crop",
    githubUrl: "https://github.com/mugheesahmad",
    liveUrl: null,
    playStoreUrl: "https://play.google.com",
    appStoreUrl: null,
    featured: false,
    privateProject: false,
    canShowScreenshots: true,
    canShowCompanyName: true,
    links: [],
    statistics: [
      { label: "Vehicles tracked", value: "1k+" },
    ],
  },
];
