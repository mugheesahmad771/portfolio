import { useState } from "react";
import type { FormEvent } from "react";
import { Link } from "react-router-dom";
import {
  Plus,
  Pencil,
  Trash2,
  GripVertical,
  Star,
  Lock,
  Eye,
  ArrowUpRight,
} from "lucide-react";
import { projects } from "../../data/content";
import type { Project } from "../../data/content";
import { Badge } from "../../components/Badge";
import { Button } from "../../components/Button";

function AdminBar() {
  return (
    <header className="h-14 border-b border-divider bg-bg-secondary flex items-center justify-between px-6 shrink-0">
      <span className="font-mono text-sm font-semibold text-heading tracking-tight">
        MA · Admin
      </span>
      <Link
        to="/"
        className="inline-flex items-center gap-1.5 text-sm text-muted hover:text-title transition-colors"
      >
        View site <ArrowUpRight size={15} strokeWidth={1.5} />
      </Link>
    </header>
  );
}

function Passcode({ onUnlock }: { onUnlock: () => void }) {
  const [value, setValue] = useState("");
  const [error, setError] = useState(false);

  function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (value.trim().length > 0) {
      onUnlock();
    } else {
      setError(true);
    }
  }

  return (
    <div className="flex-1 grid place-items-center px-6 py-20">
      <div
        className="w-full max-w-sm rounded-card bg-card border border-border p-8"
        style={{ boxShadow: "var(--shadow-md)" }}
      >
        <div className="flex items-center justify-center w-12 h-12 rounded-[12px] bg-purple/10 text-purple mx-auto">
          <Lock size={22} strokeWidth={1.5} />
        </div>
        <h2 className="mt-5 text-xl font-semibold text-heading text-center tracking-tight">
          Private area
        </h2>
        <p className="mt-2 text-sm text-muted text-center">
          Enter your admin passcode to continue.
        </p>
        <form onSubmit={handleSubmit} className="mt-6 space-y-4">
          <input
            type="password"
            placeholder="Passcode"
            value={value}
            onChange={(e) => { setValue(e.target.value); setError(false); }}
            className={`w-full h-12 rounded-input bg-bg border px-4 text-sm text-title placeholder:text-disabled focus:outline-none focus:border-primary transition-colors ${
              error ? "border-red" : "border-border"
            }`}
          />
          {error && (
            <p className="text-xs text-red">Please enter a passcode.</p>
          )}
          <button
            type="submit"
            className="w-full h-12 rounded-btn bg-primary text-bg text-sm font-semibold hover:bg-primary-hover transition-colors"
          >
            Unlock
          </button>
        </form>
      </div>
    </div>
  );
}

export default function AdminDashboard() {
  const [unlocked, setUnlocked] = useState(false);
  const [featuredIds, setFeaturedIds] = useState<Set<string>>(
    new Set(projects.filter((p) => p.featured).map((p) => p.id))
  );
  const [projectList, setProjectList] = useState<Project[]>(projects);

  function toggleFeatured(id: string) {
    setFeaturedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  function deleteProject(id: string) {
    setProjectList((prev) => prev.filter((p) => p.id !== id));
  }

  return (
    <div className="min-h-screen bg-bg text-body flex flex-col">
      <AdminBar />

      {!unlocked ? (
        <Passcode onUnlock={() => setUnlocked(true)} />
      ) : (
        <main className="flex-1 mx-auto w-full max-w-[1200px] px-6 py-10">
          {/* Page header */}
          <div className="flex items-center justify-between gap-4 mb-8">
            <div>
              <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">Admin</p>
              <h1 className="mt-2 text-2xl font-semibold text-heading tracking-tight">Projects</h1>
            </div>
            <Button to="/admin/new">
              <Plus size={18} strokeWidth={1.5} />
              Create Project
            </Button>
          </div>

          {/* Table */}
          <div
            className="rounded-card bg-card border border-border overflow-hidden"
            style={{ boxShadow: "var(--shadow-sm)" }}
          >
            {/* Table header */}
            <div className="grid grid-cols-[auto_1fr_auto_auto_auto] items-center gap-4 px-5 py-3 border-b border-divider bg-bg-secondary">
              <span className="w-5" />
              <p className="font-mono text-xs uppercase tracking-widest text-disabled">Project</p>
              <p className="font-mono text-xs uppercase tracking-widest text-disabled hidden lg:block">Status</p>
              <p className="font-mono text-xs uppercase tracking-widest text-disabled hidden lg:block">Role</p>
              <p className="font-mono text-xs uppercase tracking-widest text-disabled">Actions</p>
            </div>

            {projectList.length === 0 && (
              <div className="py-16 text-center text-muted text-sm">
                No projects yet.{" "}
                <Link to="/admin/new" className="text-primary hover:text-primary-hover">
                  Create one
                </Link>
              </div>
            )}

            {projectList.map((project, idx) => (
              <div
                key={project.id}
                className={`grid grid-cols-[auto_1fr_auto_auto_auto] items-center gap-4 px-5 py-4 hover:bg-bg-secondary transition-colors ${
                  idx < projectList.length - 1 ? "border-b border-divider" : ""
                }`}
              >
                {/* Drag handle */}
                <button
                  aria-label="Reorder"
                  className="text-disabled hover:text-muted transition-colors cursor-grab"
                >
                  <GripVertical size={16} strokeWidth={1.5} />
                </button>

                {/* Title + thumbnail */}
                <div className="flex items-center gap-3 min-w-0">
                  <div className="w-10 h-10 rounded-[8px] bg-elevated border border-border shrink-0 overflow-hidden">
                    {project.thumbnail ? (
                      <img
                        src={project.thumbnail}
                        alt={project.title}
                        className="w-full h-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full grid place-items-center">
                        <Eye size={14} strokeWidth={1.5} className="text-disabled" />
                      </div>
                    )}
                  </div>
                  <div className="min-w-0">
                    <p className="text-sm font-semibold text-heading truncate">{project.title}</p>
                    <p className="text-xs text-muted font-mono truncate">{project.slug}</p>
                  </div>
                </div>

                {/* Status badges */}
                <div className="hidden lg:flex flex-wrap gap-1.5">
                  {featuredIds.has(project.id) && (
                    <Badge tone="featured">Featured</Badge>
                  )}
                  {project.privateProject && (
                    <Badge tone="private">NDA</Badge>
                  )}
                  {project.currentlyWorking && (
                    <Badge tone="open" dot>Ongoing</Badge>
                  )}
                </div>

                {/* Role */}
                <p className="hidden lg:block text-xs text-muted max-w-[160px] truncate">
                  {project.role}
                </p>

                {/* Actions */}
                <div className="flex items-center gap-1">
                  <button
                    aria-label="Toggle featured"
                    onClick={() => toggleFeatured(project.id)}
                    className={`w-8 h-8 grid place-items-center rounded-[8px] transition-colors ${
                      featuredIds.has(project.id)
                        ? "text-orange bg-orange/10"
                        : "text-disabled hover:text-muted hover:bg-elevated"
                    }`}
                  >
                    <Star size={15} strokeWidth={1.5} />
                  </button>
                  <Link
                    to={`/admin/edit/${project.slug}`}
                    aria-label="Edit"
                    className="w-8 h-8 grid place-items-center rounded-[8px] text-disabled hover:text-primary hover:bg-primary/10 transition-colors"
                  >
                    <Pencil size={15} strokeWidth={1.5} />
                  </Link>
                  <button
                    aria-label="Delete"
                    onClick={() => deleteProject(project.id)}
                    className="w-8 h-8 grid place-items-center rounded-[8px] text-disabled hover:text-red hover:bg-red/10 transition-colors"
                  >
                    <Trash2 size={15} strokeWidth={1.5} />
                  </button>
                </div>
              </div>
            ))}
          </div>
        </main>
      )}
    </div>
  );
}
