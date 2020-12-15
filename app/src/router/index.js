import Vue from "vue";
import VueRouter from "vue-router";

import Dashboard from "@/views/Dashboard";
import Publishers from "@/views/Publishers";
import Login from "@/views/Login";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Dashboard,
    beforeEnter: (to, from, next) => {
      if (!localStorage.getItem("token")) next("/login");
      else next("/dashboard");
    },
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
    beforeEnter: async (to, from, next) => {
      if (localStorage.getItem("token")) next("/dashboard");

      next();
    },
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: Dashboard,
    beforeEnter: (to, from, next) => {
      if (!localStorage.getItem("token")) next("/login");
      next();
    },
  },

  {
    path: "/publishers",
    name: "Publishers",
    component: Publishers,
    beforeEnter: (to, from, next) => {
      if (!localStorage.getItem("token")) next("/login");
      next();
    },
  },
];

const router = new VueRouter({
  routes,
});

export default router;
