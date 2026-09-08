import { Routes, Route } from "react-router-dom";

import {Layout} from "./components/Layout";
import Home from "./src/screens/Home";
import About from "./src/screens/About";
import Experience from "./src/screens/Experience";
import Projects from "./src/screens/Projects";
import ProjectDetails from "./src/screens/ProjectDetails";
import Skills from "./src/screens/Skills";
import Resume from "./src/screens/Resume";
import Contact from "./src/screens/Contact";
import NotFound from "./src/screens/NotFound";
import AdminDashboard from "./src/screens/AdminDashboard";
import AdminCreate from "./src/screens/AdminCreate";

export function AppRoutes() {
    return (
        <Routes>
            <Route element={<Layout />}>
                <Route path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route path="/experience" element={<Experience />} />
                <Route path="/projects" element={<Projects />} />
                <Route path="/projects/:slug" element={<ProjectDetails />} />
                <Route path="/skills" element={<Skills />} />
                <Route path="/resume" element={<Resume />} />
                <Route path="/contact" element={<Contact />} />
                <Route path="*" element={<NotFound />} />
            </Route>
            <Route path="/admin" element={<AdminDashboard />} />
            <Route path="/admin/new" element={<AdminCreate />} />
        </Routes>
    );
}