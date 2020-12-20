import Vue from "vue";
import VueRouter from "vue-router";
import store from "@/store";

import Login from "@/views/Login";

import Books from "@/views/Books";
import Authors from "@/views/Authors";
import Categories from "@/views/Categories";
import Publishers from "@/views/Publishers";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Login,
    beforeEnter: async (to, from, next) => {
      const isValid = await store.dispatch("auth/validateToken");
      console.log(isValid);
      if (isValid) next("/books");
      next();
    },
  },

  {
    path: "/books",
    name: "Books",
    icon: "mdi-book",
    component: Books,
    beforeEnter: async (to, from, next) => {
      const validToken = await store.dispatch("auth/validateToken");
      if (!validToken) next("/");

      next();
    },
  },

  {
    path: "/publishers",
    name: "Publishers",
    icon: "mdi-city",
    component: Publishers,
    beforeEnter: async (to, from, next) => {
      const validToken = await store.dispatch("auth/validateToken");
      if (!validToken) next("/");

      next();
    },
  },

  {
    path: "/authors",
    name: "Authors",
    icon: "mdi-pen",
    component: Authors,
    beforeEnter: async (to, from, next) => {
      const validToken = await store.dispatch("auth/validateToken");
      if (!validToken) next("/");

      next();
    },
  },
  {
    path: "/categories",
    name: "Categories",
    icon: "mdi-view-grid",
    component: Categories,
    beforeEnter: async (to, from, next) => {
      const validToken = await store.dispatch("auth/validateToken");
      if (!validToken) next("/");

      next();
    },
  },
];

const router = new VueRouter({
  routes,
});

export default router;
