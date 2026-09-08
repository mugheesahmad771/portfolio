import { Link } from "react-router-dom";
import { ArrowUpRight, Lock, BarChart3 } from "lucide-react";
import type { Project } from "../data/content";
import { TechChip } from "./TechChip";
import { Badge } from "./Badge";

export function ProjectCard({ project }: { project: Project }) {
  const showImage = project.canShowScreenshots && project.thumbnail;
  const company = project.canShowCompanyName ? project.company : "Confidential client";

  return (
    <Link
      to={`/projects/${project.slug}`}
      className="group flex flex-col rounded-card bg-card border border-border overflow-hidden transition-all duration-250 hover:border-primary hover:-translate-y-1.5"
      style={{ boxShadow: "var(--shadow-sm)" }}
    >
      <div className="relative aspect-[16/10] overflow-hidden bg-bg-secondary">
        {showImage ? (
          <img
            src={project.thumbnail as string}
            alt={project.title}
            loading="lazy"
            className="w-full h-full object-cover opacity-90 group-hover:opacity-100 group-hover:scale-[1.03] transition-all duration-300"
          />
        ) : (
          <div className="w-full h-full flex flex-col justify-center gap-4 px-7">
            <div className="flex items-center gap-2 text-muted">
              <BarChart3 size={16} strokeWidth={1.5} />
              <span className="font-mono text-xs uppercase tracking-widest">Impact</span>
            </div>
            <div className="flex flex-wrap gap-x-8 gap-y-4">
              {project.statistics.slice(0, 3).map((s) => (
                <div key={s.label}>
                  <div className="text-2xl font-semibold text-heading tracking-tight">{s.value}</div>
                  <div className="text-xs text-muted mt-1">{s.label}</div>
                </div>
              ))}
            </div>
          </div>
        )}
        <div className="absolute top-4 left-4 flex gap-2">
          {project.featured && <Badge tone="featured">Featured</Badge>}
          {project.privateProject && (
            <Badge tone="private">
              <Lock size={11} strokeWidth={2} /> NDA
            </Badge>
          )}
        </div>
      </div>

      <div className="flex flex-col flex-1 p-6">
        <div className="flex items-start justify-between gap-3">
          <div>
            <h3 className="text-lg font-semibold text-heading tracking-tight group-hover:text-primary transition-colors">
              {project.title}
            </h3>
            <p className="mt-1 text-sm text-muted">
              {project.role} · {company}
            </p>
          </div>
          <ArrowUpRight
            size={20}
            strokeWidth={1.5}
            className="text-disabled group-hover:text-primary transition-colors shrink-0"
          />
        </div>

        <p className="mt-4 text-sm text-body leading-relaxed line-clamp-2">
          {project.shortDescription}
        </p>

        <div className="mt-auto pt-5 flex flex-wrap gap-2">
          {project.technologies.slice(0, 4).map((t) => (
            <TechChip key={t} label={t} size="sm" />
          ))}
        </div>
      </div>
    </Link>
  );
}
