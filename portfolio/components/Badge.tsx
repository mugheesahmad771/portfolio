import type { ReactNode } from "react";

type Tone = "open" | "featured" | "new" | "private";

const tones: Record<Tone, string> = {
  open: "bg-green/10 text-green border-green/30",
  featured: "bg-orange/10 text-orange border-orange/30",
  new: "bg-primary/10 text-primary border-primary/30",
  private: "bg-purple/10 text-purple border-purple/30",
};

interface Props {
  tone: Tone;
  children: ReactNode;
  dot?: boolean;
}

export function Badge({ tone, children, dot }: Props) {
  return (
    <span
      className={`inline-flex items-center gap-1.5 rounded-pill border px-3 py-1 text-xs font-medium ${tones[tone]}`}
    >
      {dot && <span className="w-1.5 h-1.5 rounded-full bg-current" />}
      {children}
    </span>
  );
}
