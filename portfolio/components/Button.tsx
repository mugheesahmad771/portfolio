import type { ReactNode } from "react";
import { Link } from "react-router-dom";

type Variant = "primary" | "secondary" | "ghost";

const base =
  "inline-flex items-center justify-center gap-2 h-12 px-6 rounded-btn text-sm font-semibold transition-colors";

const variants: Record<Variant, string> = {
  primary: "bg-primary text-bg hover:bg-primary-hover",
  secondary: "border border-primary text-primary hover:bg-primary/10",
  ghost: "border border-border text-title hover:border-elevated hover:text-heading",
};

interface Props {
  children: ReactNode;
  variant?: Variant;
  to?: string;
  href?: string;
  onClick?: () => void;
}

export function Button({ children, variant = "primary", to, href, onClick }: Props) {
  const cls = `${base} ${variants[variant]}`;
  if (to) return <Link to={to} className={cls}>{children}</Link>;
  if (href) return <a href={href} className={cls}>{children}</a>;
  return <button onClick={onClick} className={cls}>{children}</button>;
}
