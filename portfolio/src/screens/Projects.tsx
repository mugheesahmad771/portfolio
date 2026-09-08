import { useMemo, useState } from "react";
import { Search, SlidersHorizontal } from "lucide-react";
import { projects } from "../../data/content";
import { ProjectCard } from "../../components/ProjectCard";
import { SectionHeader } from "../../components/SectionHeader";

const filters = ["All", "Flutter", "React Native", "Angular", "ASP.NET Core"];

export default function Projects() {
  const [query, setQuery] = useState("");
  const [active, setActive] = useState("All");

  const results = useMemo(() => {
    return projects.filter((p) => {
      const matchesFilter =
        active === "All" || p.technologies.some((t) => t.includes(active));
      const q = query.trim().toLowerCase();
      const matchesQuery =
        !q ||
        p.title.toLowerCase().includes(q) ||
        p.shortDescription.toLowerCase().includes(q) ||
        p.technologies.some((t) => t.toLowerCase().includes(q));
      return matchesFilter && matchesQuery;
    });
  }, [query, active]);

  return (
    <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-16">
      <SectionHeader
        eyebrow="Portfolio"
        title="Projects"
        description="Production applications across mobile, web and enterprise backends. Confidential work is shown NDA-safe."
      />

      {/* Controls */}
      <div className="mt-12 flex flex-col lg:flex-row lg:items-center gap-4 justify-between">
        <div className="flex items-center gap-2 flex-wrap">
          <SlidersHorizontal size={16} strokeWidth={1.5} className="text-disabled" />
          {filters.map((f) => (
            <button
              key={f}
              onClick={() => setActive(f)}
              className={`px-4 py-2 rounded-pill text-sm font-medium transition-colors border ${
                active === f
                  ? "bg-primary text-bg border-primary"
                  : "bg-card border-border text-muted hover:text-title hover:border-elevated"
              }`}
            >
              {f}
            </button>
          ))}
        </div>
        <div className="relative lg:w-72">
          <Search
            size={18}
            strokeWidth={1.5}
            className="absolute left-4 top-1/2 -translate-y-1/2 text-disabled"
          />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search projects..."
            className="w-full h-12 pl-11 pr-4 rounded-input bg-card border border-border text-sm text-body placeholder:text-disabled focus:outline-none focus:border-primary transition-colors"
          />
        </div>
      </div>

      {/* Grid */}
      {results.length > 0 ? (
        <div className="mt-10 grid md:grid-cols-2 xl:grid-cols-3 gap-6">
          {results.map((p) => (
            <ProjectCard key={p.id} project={p} />
          ))}
        </div>
      ) : (
        <div className="mt-16 text-center py-20 rounded-card border border-dashed border-border">
          <p className="text-title font-medium">No projects match your search.</p>
          <p className="mt-2 text-sm text-muted">Try a different technology or keyword.</p>
        </div>
      )}
    </div>
  );
}
