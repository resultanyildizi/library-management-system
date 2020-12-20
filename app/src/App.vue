<template>
  <v-app>
    <v-main>
      <navbar />
      <router-view> </router-view>
    </v-main>
  </v-app>
</template>

<script>
import Navbar from "./components/Core/Navbar.vue";
export default {
  name: "App",
  components: {
    Navbar,
  },
};
</script>

<style>
html::-webkit-scrollbar {
  display: none;
}
html {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}

::-webkit-scrollbar {
  display: none;
}
* {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}

@font-face {
  font-family: "GoogleSansMedium";
  src: local("GoogleSansMedium"),
    url(./assets/google_sans/GoogleSans-Medium.ttf) format("truetype");
}
@font-face {
  font-family: "GoogleSansRegular";
  src: local("GoogleSansRegular"),
    url(./assets/google_sans/GoogleSans-Regular.ttf) format("truetype");
}

.google-sans-medium {
  font-family: "GoogleSansMedium";
}

.google-sans-regular {
  font-family: "GoogleSansRegular";
}
</style>
