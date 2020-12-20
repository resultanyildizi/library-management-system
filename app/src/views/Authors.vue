<template>
  <section style="height: 100%" class="px-8">
    <add-author-form ref="addAuthorForm" />
    <circular-progress v-if="!getAuthors" />
    <v-container v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Author or Translator'"
        :action="fabAction"
      />
      <h1 class="google-sans-regular pl-6 mb-0 text-center">
        📝 Authors & Translators 📝
      </h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <author-list :authors="getAuthors" />
    </v-container>
  </section>
</template>

<script>
import CircularProgress from "@/components/Core/CircularProgress";
import AuthorList from "../components/Author/AuthorList.vue";
import FloatingActionButton from "../components/Core/FloatingActionButton.vue";
import AddAuthorForm from "../components/Author/AddAuthorForm";
import { mapActions, mapGetters } from "vuex";
export default {
  name: "Authors",
  components: {
    CircularProgress,
    AuthorList,
    FloatingActionButton,
    AddAuthorForm,
  },
  methods: {
    ...mapActions("author", ["bindAuthors"]),
    ...mapActions("country", ["bindCountries"]),
    fabAction() {
      this.$refs.addAuthorForm.dialog = true;
    },
  },
  computed: {
    ...mapGetters("author", ["getAuthors"]),
  },
  created() {
    this.bindAuthors();
  },
};
</script>

<style>
</style>