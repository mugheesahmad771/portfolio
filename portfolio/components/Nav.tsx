import { useEffect, useState } from "react";
import { Link, NavLink } from "react-router-dom";
import { Menu, X, Moon } from "lucide-react";

const links = [
  { to: "/", label: "Home" },
  { to: "/about", label: "About" },
  { to: "/experience", label: "Experience" },
  { to: "/projects", label: "Projects" },
  { to: "/skills", label: "Skills" },
  { to: "/resume", label: "Resume" },
  { to: "/contact", label: "Contact" },
];

export function Nav() {
  const [scrolled, setScrolled] = useState(false);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 12);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <header
      className={`fixed top-0 inset-x-0 z-50 transition-colors duration-300 ${
        scrolled ? "bg-bg/90 border-b border-divider" : "bg-transparent border-b border-transparent"
      }`}
    >
      <div className="mx-auto max-w-[1440px] px-6 lg:px-16 h-20 flex items-center justify-between">
        <Link to="/" className="flex items-center gap-3">
          <span className="grid place-items-center w-9 h-9 rounded-[10px] bg-primary text-bg font-bold text-sm">
            MA
          </span>
          <span className="text-heading font-semibold text-[15px] tracking-tight">Mughees Ahmad</span>
        </Link>

        <nav className="hidden lg:flex items-center gap-8">
          {links.map((l) => (
            <NavLink
              key={l.to}
              to={l.to}
              end={l.to === "/"}
              className={({ isActive }) =>
                `text-sm transition-colors ${
                  isActive ? "text-primary font-medium" : "text-muted hover:text-title"
                }`
              }
            >
              {l.label}
            </NavLink>
          ))}
        </nav>

        <div className="hidden lg:flex items-center gap-4">
          <button
            aria-label="Toggle theme"
            className="grid place-items-center w-9 h-9 rounded-[10px] border border-border text-muted hover:text-title hover:border-elevated transition-colors"
          >
            <Moon size={16} strokeWidth={1.5} />
          </button>
          <Link
            to="/contact"
            className="px-5 h-11 grid place-items-center rounded-btn bg-primary text-bg text-sm font-semibold hover:bg-primary-hover transition-colors"
          >
            Hire Me
          </Link>
        </div>

        <button
          className="lg:hidden text-title"
          onClick={() => setOpen(true)}
          aria-label="Open menu"
        >
          <Menu size={24} strokeWidth={1.5} />
        </button>
      </div>

      {open && (
        <div className="lg:hidden fixed inset-0 z-50 bg-bg/95">
          <div className="flex items-center justify-between px-6 h-20">
            <span className="text-heading font-semibold tracking-tight">Menu</span>
            <button onClick={() => setOpen(false)} aria-label="Close menu" className="text-title">
              <X size={24} strokeWidth={1.5} />
            </button>
          </div>
          <nav className="flex flex-col px-6 gap-2">
            {links.map((l) => (
              <NavLink
                key={l.to}
                to={l.to}
                end={l.to === "/"}
                onClick={() => setOpen(false)}
                className={({ isActive }) =>
                  `py-3 text-lg border-b border-divider ${
                    isActive ? "text-primary" : "text-title"
                  }`
                }
              >
                {l.label}
              </NavLink>
            ))}
            <Link
              to="/contact"
              onClick={() => setOpen(false)}
              className="mt-4 h-12 grid place-items-center rounded-btn bg-primary text-bg font-semibold"
            >
              Hire Me
            </Link>
          </nav>
        </div>
      )}
    </header>
  );
}
