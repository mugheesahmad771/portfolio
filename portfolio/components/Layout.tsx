import { Outlet } from "react-router-dom";
import { Nav } from "./Nav";
import { Footer } from "./Footer";

export function Layout() {
  return (
    <div className="min-h-screen bg-bg text-body">
      <Nav />
      <main className="pt-20">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}
