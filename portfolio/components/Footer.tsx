import { Link } from "react-router-dom";
import { MapPin, Mail, Phone } from "lucide-react";
import { profile } from "../data/content";

const nav = [
  { to: "/about", label: "About" },
  { to: "/experience", label: "Experience" },
  { to: "/projects", label: "Projects" },
  { to: "/skills", label: "Skills" },
  { to: "/resume", label: "Resume" },
  { to: "/contact", label: "Contact" },
];

export function Footer() {
  return (
    <footer className="border-t border-divider bg-bg-secondary">
      <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-16">
        <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-12">
          <div className="max-w-sm">
            <div className="flex items-center gap-3">
              <span className="grid place-items-center w-9 h-9 rounded-[10px] bg-primary text-bg font-bold text-sm">
                MA
              </span>
              <span className="text-heading font-semibold tracking-tight">Mughees Ahmad</span>
            </div>
            <p className="mt-4 text-sm text-muted leading-relaxed">{profile.tagline}</p>
            <div className="mt-6 flex items-center gap-3">
              <a href={profile.github} className="grid place-items-center w-10 h-10 rounded-[12px] border border-border text-muted hover:text-heading hover:border-primary transition-colors">
                <MapPin size={18} strokeWidth={1.5} />
              </a>
              <a href={profile.linkedin} className="grid place-items-center w-10 h-10 rounded-[12px] border border-border text-muted hover:text-heading hover:border-primary transition-colors">
                <MapPin size={18} strokeWidth={1.5} />
              </a>
              <a href={`mailto:${profile.email}`} className="grid place-items-center w-10 h-10 rounded-[12px] border border-border text-muted hover:text-heading hover:border-primary transition-colors">
                <Mail size={18} strokeWidth={1.5} />
              </a>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-12">
            <div>
              <p className="font-mono text-xs uppercase tracking-widest text-disabled">Navigate</p>
              <ul className="mt-4 space-y-3">
                {nav.map((n) => (
                  <li key={n.to}>
                    <Link to={n.to} className="text-sm text-muted hover:text-primary transition-colors">
                      {n.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
            <div>
              <p className="font-mono text-xs uppercase tracking-widest text-disabled">Contact</p>
              <ul className="mt-4 space-y-3 text-sm text-muted">
                <li className="flex items-center gap-2">
                  <Mail size={14} strokeWidth={1.5} /> {profile.email}
                </li>
                <li className="flex items-center gap-2">
                  <Phone size={14} strokeWidth={1.5} /> {profile.phone}
                </li>
                <li>{profile.location}</li>
              </ul>
            </div>
          </div>
        </div>

        <div className="mt-14 pt-8 border-t border-divider flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-disabled">© 2026 Mughees Ahmad. All rights reserved.</p>
          <p className="text-xs text-disabled font-mono">Built with Flutter</p>
        </div>
      </div>
    </footer>
  );
}
