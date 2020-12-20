<template>
  <section>
    <add-book-form ref="addBookForm" />
    <!-- Top Navigation -->
    <v-container class="px-lg-16">
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Book'"
        :action="fabAction"
      />
      <h1 class="google-sans-regular pl-6 mb-0 text-center">📔 Books 📔</h1>
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
import { mapActions } from "vuex";
import Book from "@/components/Book/Book";
import FloatingActionButton from "@/components/Core/FloatingActionButton";
import AddBookForm from "../components/Book/AddBookForm.vue";
export default {
  name: "Books",
  components: {
    Book,
    FloatingActionButton,
    AddBookForm,
  },
  methods: {
    ...mapActions("language", ["bindLanguages"]),
    ...mapActions("author", ["bindAuthors"]),
    ...mapActions("publisher", ["bindPublishers"]),
    ...mapActions("category", ["bindCategories"]),
    fabAction() {
      console.log("Action");
      this.$refs.addBookForm.dialog = true;
    },
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

  created() {
    this.bindLanguages();
    this.bindAuthors();
    this.bindPublishers();
    this.bindCategories();
  },
};
</script>

<style scoped>
.v-application ul,
.v-application ol {
  padding: 0;
}
</style>
