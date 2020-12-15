<template>
  <section>
    <!-- Top Navigation -->
    <v-container class="px-lg-16">
      <h1 class="google-sans-regular pl-6 mb-0 text-center">Books</h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <ul>
        <v-row jutify="center">
          <v-col v-for="i in 13" :key="i" md="6" xl="4" class="pa-0 mb-16">
            <book :style="{ 'padding-left': responsivePadding }" />
          </v-col>
        </v-row>
      </ul>
    </v-container>
  </section>
</template>

<script>
import Book from "@/components/Book";
export default {
  name: "Dashboard",
  components: {
    Book,
  },
  computed: {
    responsivePadding() {
      switch (this.$vuetify.breakpoint.name) {
        case "lg":
          return "70px";
        default:
          return "100px";
      }
    },
  },
};
</script>

<style scoped>
.v-application ul,
.v-application ol {
  padding: 0;
}
</style>
