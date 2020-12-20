<template>
  <v-row>
    <v-col cols="4" v-for="category in categories" :key="category.categoryId">
      <v-card class="pa-1" color="#F5F5F5" height="100%">
        <v-treeview
          shaped
          hoverable
          open-all
          color="secondary"
          :items="[category]"
        >
          <template v-slot:prepend="{ item }">
            <v-icon color="secondary" v-if="item.children.length > 0">
              {{ "mdi-book-multiple" }}
            </v-icon>
            <v-icon color="secondary" v-else>
              {{ "mdi-book-variant" }}
            </v-icon>
          </template>
          <template slot="append" slot-scope="{ item }">
            <v-row class="px-1">
              <v-btn color="secondary" @click="openCategoryDialog(item)" icon>
                <v-icon>mdi-plus</v-icon>
              </v-btn>
              <v-btn color="primary" @click="_deleteCategory(item)" icon>
                <v-icon>mdi-delete</v-icon>
              </v-btn>
            </v-row>
          </template>
        </v-treeview>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  methods: {
    ...mapActions("category", ["deleteCategory"]),
    getNodes(items) {
      return items.map((item) => ({
        id: item.categoryId,
        name: item.name,
        children: item.children ? this.getNodes(item.children) : [],
      }));
    },
    async _deleteCategory(item) {
      const { id } = item;

      await this.deleteCategory({ categoryId: id });
    },
    openCategoryDialog(item) {
      this.$emit("openCategoryFormDialog", item);
    },
  },
  computed: {
    ...mapGetters("category", ["getCategories"]),
    categories() {
      return this.getNodes(this.getCategories);
    },
  },
};
</script>

<style>
</style>